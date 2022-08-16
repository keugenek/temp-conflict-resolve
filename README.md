# KandJ.wedding

## Project setup

```bash
npm install
```

### Compiles and hot-reloads for development

```bash
npm run serve
```

### Compiles and minifies for production

```bash
npm run build
```

### Lints and fixes files

```bash
npm run lint
```

### Build and deploy

```bash
# Dist must be created before Terraform will deploy appropriately
npm run build
cd terraform/
terraform init # If not already done
terraform apply # Create the infra
```
