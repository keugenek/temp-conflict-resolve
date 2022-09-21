<template>
  <div style="width: 100%">
    <mu-flex justify-content="center">
      <mu-card>
        <mu-card-title title="RSVP"> </mu-card-title>
        <mu-card-text>
          <mu-snackbar position="top" :open.sync="this.snackbar.open" :color="this.snackbar.error ? 'error':'success'">
            {{this.snackbar.message}}
            <span v-if="this.snackbar.messages.length != 0">
              <span v-for="message in this.snackbar.messages" :key="message">
                {{message}}<br />
              </span>
            </span>
            <mu-button flat slot="action" @click="this.snackbar.open = false">Close</mu-button>
          </mu-snackbar>
          <mu-form
            :model="form"
            ref="form"
            :label-position="this.isMobile ? 'top':'right'"
            label-width="250"
          >
            <mu-form-item prop="first" label="First Name" :rules="firstNameRules">
              <mu-text-field v-model="form.first" prop="first"></mu-text-field>
            </mu-form-item>
            <br />
            <mu-form-item prop="last" label="Last Name" :rules="lastNameRules">
              <mu-text-field v-model="form.last" prop="last"></mu-text-field>
            </mu-form-item>
            <br />
            <mu-form-item
              prop="rsvpCode"
              label="RSVP Code from Envelope"
              :rules="rsvpRules"
              help-text="Check for a white label on the inside flap"
            >
              <mu-text-field
                prop="rsvpCode"
                v-model="form.rsvpCode"
              ></mu-text-field>
            </mu-form-item>
            <br />
            <mu-form-item
              prop="reminders"
              label="Reminder one month and one week before the wedding?"
            >
              <mu-checkbox
                v-model="form.reminders"
                value="email"
                label="Email"
              ></mu-checkbox>
              <mu-checkbox
                v-model="form.reminders"
                value="text"
                label="Text"
              ></mu-checkbox>
            </mu-form-item>
            <mu-form-item
              prop="email"
              label="Email Address"
              :rules="emailRules"
              help-text="This is only used for the two reminders."
              v-if="this.form.reminders.includes('email')"
            >
              <mu-text-field prop="email" v-model="form.email"></mu-text-field>
              <br />
            </mu-form-item>
            <mu-form-item
              prop="phone"
              label="Phone Number"
              v-if="this.form.reminders.includes('text')"
              :rules="phoneRules"
              help-text="This is only used for the two reminders."
            >
              <mu-text-field prop="phone" v-model="form.phone"></mu-text-field>
              <br />
            </mu-form-item>
            <br />
            <mu-form-item
              prop="address"
              label="Return Address for Thank You Card"
              :rules="addressRules"
              help-text="This is only used for the thank you card"
            >
              <mu-text-field
                :rows="3"
                :rows-max="4"
                multi-line
                v-model="form.address"
                prop="address"
              ></mu-text-field>
            </mu-form-item>
            <br />
            <mu-form-item
              prop="hasAllergies"
              label="Do You Have Any Food Allergies?"
            >
              <mu-checkbox
                prop="allergies"
                v-model="form.hasAllergies"
                label="I have food allergies"
              ></mu-checkbox>
            </mu-form-item>
            <mu-form-item
              prop="allergies"
              :rules="allergyRules"
              v-if="form.hasAllergies"
            >
              <mu-text-field
                :rows="3"
                :rows-max="6"
                prop="allergies"
                style="margin-top: 0.75em"
                multi-line
                v-model="form.allergies"
                placeholder="Describe any food allergies and we will do our best to accommodate them."
              ></mu-text-field>
            </mu-form-item>
            <br />
            <mu-form-item prop="notes" label="Any Notes for the Bride and Groom?">
              <mu-text-field
                :rows="3"
                :rows-max="4"
                multi-line
                prop="notes"
                v-model="form.notes"
              ></mu-text-field>
            </mu-form-item>
            <mu-form-item>
              <mu-button color="primary" @click="submit">Submit RSVP</mu-button>
            </mu-form-item>
          </mu-form>
        </mu-card-text>
      </mu-card>
    </mu-flex>
  </div>
</template>

<script>
import API from '@/services/API';

export default {
  components: {},
  created() {},
  data: function() {
    return {
      snackbar: {
        open: false,
        message: '',
        error: false,
        messages: [],
      },
      firstNameRules: [
        { validate: (val) => !!val, message: "First name must be provided" },
      ],
      lastNameRules: [
        { validate: (val) => !!val, message: "Last name must be provided" },
      ],
      rsvpRules: [
        { validate: (val) => !!val, message: "RSVP code must be provided" },
      ],
      addressRules: [
        { validate: (val) => !!val, message: "Address must be provided" },
      ],
      allergyRules: [
        {
          validate: (val) => this.form.hasAllergies && !!val,
          message:
            "Must describe allergies if food allergies have been indicated.",
        },
      ],
      emailRules: [
        {
          validate: (val) => this.form.reminders.includes("email") && !!val,
          message:
            "Email must be provided if phone reminders have been selected.",
        },
      ],
      phoneRules: [
        {
          validate: (val) => this.form.reminders.includes("text") && !!val,
          message:
            "Phone number must be provided if text reminders have been selected.",
        },
      ],
      form: {
        first: "",
        last: "",
        reminders: [],
        email: "",
        phone: "",
        address: "",
        hasAllergies: false,
        allergies: "",
        rsvpCode: "",
        notes: "",
      },
      isMobile: false,
    };
  },
  mounted() {
    this.onResize();
    window.addEventListener('resize', this.onResize);
  },
  methods: {
    onResize() {
      this.isMobile = window.innerWidth < 600;
    },
    showSnackbar(message, error=false, messages=[]) {
      this.snackbar.open = true;
      this.snackbar.message = message;
      this.snackbar.error = error;
      this.snackbar.messages = messages;
      setTimeout(() => {
        this.snackbar.open = false;
      }, 3000);
    },
    submit() {
      this.$refs.form.validate().then(async (result) => {
        if (result) {
          try {
            await API.post("rsvp", JSON.stringify({
              rsvpCode: this.form.rsvpCode,
              firstName: this.form.first,
              lastName: this.form.last,
              smsReminder: this.form.reminders.includes("text"),
              phone: this.form.phone,
              emailReminder: this.form.reminders.includes("email"),
              email: this.form.email,
              address: this.form.address,
              allergies: this.form.hasAllergies,
              allergyDetails: this.form.allergies,
              notes: this.form.notes,
            }));
            this.showSnackbar("Submission Saved");
          } catch (err) {
            console.error(err);
            if ('error' in err.response.data) {
              if ('messages' in err.response.data) {
                this.showSnackbar(err.response.data.error + ": ", true, err.response.data.messages);
              } else {
                this.showSnackbar(err.response.data.error, true);
              }
            }
          }
        }
      });
    },
  },
};
</script>

<style scoped>
</style>
