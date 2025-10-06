# GCP Terraform - Modułowa Konfiguracja Google Cloud Platform

![Terraform](https://img.shields.io/badge/Terraform-1.0+-7C3AED?style=flat-square&logo=terraform)
![Google Cloud](https://img.shields.io/badge/Google%20Cloud-Platform-4285F4?style=flat-square&logo=google-cloud)
![HCL](https://img.shields.io/badge/HCL-98.3%25-623CE4?style=flat-square)

## 📋 Opis Projektu

Repozytorium zawiera **modułową konfigurację Terraform** dla Google Cloud Platform, stworzoną w celach demonstracji umiejętności i jako praktyczna ściągawka podczas nauki języka HCL. Projekt implementuje architekturę opartą na modułach wielokrotnego użytku z oddzielnymi środowiskami produkcyjnymi.

## 🎯 Cel Projektu

- **Prezentacja umiejętności** - Demonstracja znajomości Terraform i GCP
- **Ściągawka edukacyjna** - Praktyczne przykłady implementacji
- **Architektura modułowa** - Kod wielokrotnego użytku
- **Ciągły rozwój** - Regularne aktualizacje i rozszerzenia

## 🏗️ Struktura Projektu

```
gcp-terraform/
├── Envs/                    # Środowiska wdrożeniowe
│   ├── provider.tf          # Konfiguracja dostawców
│   ├── variables.tf         # Zmienne globalne
│   ├── terraform.tfvars     # Wartości zmiennych
│   └── Production/          # Środowisko produkcyjne
│       ├── Database/        # Instancje Cloud SQL
│       ├── LoadBalancer/    # HTTP/HTTPS Load Balancery
│       ├── VirtualMachine/  # Compute Engine instances
│       ├── bucket_static_site/ # Hosting statycznych stron
│       ├── firewall/        # Reguły zapory sieciowej
│       ├── kubernetes/      # Klastry GKE
│       ├── terraform_state_bucket/ # Bucket dla state Terraform
│       └── vpc/             # Sieci VPC
├── Modules/                 # Moduły wielokrotnego użytku
│   ├── Database/            # Moduł Cloud SQL
│   ├── LoadBalancer/        # Moduł Load Balancera
│   ├── VPC/                 # Moduł sieci VPC
│   ├── VirtualMachine/      # Moduł VM
│   ├── firewall/            # Moduł firewall
│   ├── kubernetes/          # Moduł GKE
│   ├── bucket_static_site/  # Moduł static hosting
│   └── terraform_state_bucket/ # Moduł state bucket
├── Key/                     # Klucze dostępowe (credentials)
└── .idea/                   # Konfiguracja IDE
```

## 🚀 Jak Rozpocząć

### Wymagania Wstępne

- **Terraform** >= 1.0
- **Google Cloud SDK** (gcloud)
- **Projekt GCP** z włączonymi API
- **Service Account** z odpowiednimi uprawnieniami

### Konfiguracja Początkowa

1. **Sklonuj repozytorium**:
   ```bash
   git clone https://github.com/Niesiek/gcp-terraform.git
   cd gcp-terraform
   ```

2. **Skonfiguruj klucze dostępowe**:
   ```bash
   # Umieść plik JSON service account w folderze Key/
   cp your-service-account.json Key/
   ```

3. **Zmodyfikuj plik Envs/terraform.tfvars**:
   ```hcl
   project = "twoj-projekt-gcp-id"
   region = "europe-west3"
   ```

4. **Zainicjalizuj Terraform**:
   ```bash
   cd Envs/
   terraform init
   ```

## 📦 Szczegółowy Opis Modułów

### 🌐 1. Moduł VPC (Modules/VPC/)

**Plik główny**: `main.tf`

**Funkcjonalność**:
- Tworzy wirtualną sieć prywatną (VPC)
- Konfiguruje podsieci regionalne
- Zarządza routing mode (REGIONAL/GLOBAL)

**Zasoby tworzone**:
```hcl
resource "google_compute_network" "vpc"
resource "google_compute_subnetwork" "subnets"
```

**Konfigurowane parametry**:
- `name` - nazwa VPC z prefiksem
- `auto_create_subnetworks` - automatyczne tworzenie podsieci
- `routing_mode` - tryb routingu
- `subnets` - mapa podsieci z CIDR i regionami

### 🔐 2. Moduł Firewall (Modules/firewall/)

**Plik główny**: `main.tf`

**Funkcjonalność**:
- Definiuje reguły zapory sieciowej
- Kontroluje ruch ingress/egress
- Przypisuje tagi sieciowe

**Zasoby tworzone**:
```hcl
resource "google_compute_firewall" "allow_rules"
```

**Konfigurowane parametry**:
- `allow_firewall_rules` - mapa reguł zezwalających
- `protocol` - protokół (TCP/UDP/ICMP)
- `ports` - dozwolone porty
- `source_ranges` - zakresy źródłowe IP
- `target_tags` - tagi docelowe

### 💻 3. Moduł Virtual Machine (Modules/VirtualMachine/)

**Plik główny**: `main.tf`

**Funkcjonalność**:
- Tworzy instancje Compute Engine
- Konfiguruje dyski boot i dodatkowe
- Zarządza adresami IP statycznymi
- Implementuje startup scripts i SSH keys

**Zasoby tworzone**:
```hcl
resource "google_compute_instance" "main"
resource "google_compute_address" "internal"
```

**Konfigurowane parametry**:
- `compute_engines` - mapa instancji VM
- `machine_type` - typ maszyny (e2-micro, n2-standard-2)
- `boot_image` - obraz systemu operacyjnego
- `network_tags` - tagi sieciowe
- `deletion_protection` - ochrona przed usunięciem

**Funkcje zaawansowane**:
- Statyczne IP wewnętrzne z CIDR calculation
- Automatyczne ładowanie SSH keys z plików
- Startup script z pliku `startup-script.sh`

### 🗃️ 4. Moduł Database (Modules/Database/)

**Plik główny**: `main.tf`

**Funkcjonalność**:
- Tworzy instancję Cloud SQL MySQL 8.0
- Konfiguruje użytkowników bazy danych
- Zarządza authorized networks dla dostępu

**Zasoby tworzone**:
```hcl
resource "google_sql_database_instance" "mysql_db"
resource "google_sql_user" "admin"
resource "google_sql_user" "mysql_user"
resource "google_sql_database" "app_database"
```

**Konfigurowane parametry**:
- `database_version` - wersja MySQL (domyślnie MYSQL_8_0)
- `tier` - rozmiar instancji
- `admin_password` - hasło administratora (sensitive)
- `mysql_user_password` - hasło użytkownika MySQL (sensitive)
- `allowed_ips` - lista dozwolonych adresów IP

### ⚖️ 5. Moduł Load Balancer (Modules/LoadBalancer/)

**Plik główny**: `main.tf`

**Funkcjonalność**:
- Tworzy HTTP Load Balancer globalny
- Konfiguruje backend services i health checks
- Zarządza instance groups

**Zasoby tworzone**:
```hcl
resource "google_compute_instance_group" "instance_group"
resource "google_compute_health_check" "lb_health_check"
resource "google_compute_backend_service" "lb_backend_service"
resource "google_compute_url_map" "lb_url_map"
resource "google_compute_target_http_proxy" "lb_http_proxy"
resource "google_compute_global_forwarding_rule" "lb_fronted"
```

**Konfigurowane parametry**:
- `health_check_name` - nazwa health check
- `backend_service_name` - nazwa backend service
- `url_map_name` - nazwa URL map
- Health check path: `/health` na porcie 80

### 🏗️ 6. Moduł Kubernetes (Modules/kubernetes/)

**Plik główny**: `main.tf`

**Funkcjonalność**:
- Tworzy klastry GKE (Google Kubernetes Engine)
- Konfiguruje private clusters z autoscaling
- Zarządza node pools

**Zasoby tworzone**:
```hcl
resource "google_container_cluster" "primary"
```

**Konfigurowane parametry**:
- `cluster_count` - liczba klastrów do utworzenia
- `enable_private_nodes` - włączenie prywatnych węzłów
- `node_min_count/node_max_count` - limity autoskalowania
- `node_machine_type` - typ maszyny dla węzłów
- `trusted_ip_range` - dozwolony zakres IP dla master API

### 🌐 7. Moduł Static Site Bucket (Modules/bucket_static_site/)

**Plik główny**: `main.tf`

**Funkcjonalność**:
- Tworzy bucket Cloud Storage do hostingu stron
- Konfiguruje website hosting
- Wgrywa domyślne pliki HTML

**Zasoby tworzone**:
```hcl
resource "google_storage_bucket" "static-site"
resource "google_storage_bucket_object" "starting_page"
resource "google_storage_bucket_object" "not_found_page"
```

**Konfigurowane parametry**:
- `main_page_suffix` - strona główna (index.html)
- `not_found_page` - strona 404
- `versioning` - włączenie wersjonowania
- `force_destroy` - wymuszenie usunięcia

### 🔒 8. Moduł Terraform State Bucket (Modules/terraform_state_bucket/)

**Plik główny**: `main.tf`

**Funkcjonalność**:
- Tworzy bezpieczny bucket dla Terraform state
- Implementuje lifecycle policies
- Konfiguruje logging i labeling

**Zasoby tworzone**:
```hcl
resource "google_storage_bucket" "terraform_state"
```

**Funkcje bezpieczeństwa**:
- **Versioning** - wersjonowanie plików state
- **Lifecycle rules** - automatyczne usuwanie starych wersji po 90 dniach
- **Uniform bucket-level access** - jednolite kontrole dostępu
- **Prevent destroy** - ochrona przed przypadkowym usunięciem
- **Logging** - logowanie dostępu do bucket

## 🎛️ Konfiguracja Środowisk

### Struktura Envs/Production/

Każdy komponent infrastruktury ma swój własny folder z plikami:

- **main.tf** - wywołanie odpowiedniego modułu
- **variables.tf** - definicje zmiennych lokalnych
- **terraform.tfvars** - wartości zmiennych
- **outputs.tf** - wartości wyjściowe (gdzie dostępne)

### Przykład użycia modułu Database:

**Envs/Production/Database/main.tf**:
```hcl
module "database" {
  source = "../../../Modules/Database"
  database_name = var.database_name
  admin_password = var.admin_password
  allowed_ips = var.allowed_ips
  environment = var.environment
  mysql_user_password = var.mysql_user_password
  project = var.project
  region = var.region
}
```

## 📋 Provider Configuration

**Envs/provider.tf**:
```hcl
terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
      version = "6.13.0"
    }
    google = {
      source = "hashicorp/google"
      version = "6.13.0"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
  credentials = file("../Key/[your-service-account].json")
}
```

## 🔑 Zmienne Globalne

**Envs/variables.tf**:
```hcl
variable "project" {
  description = "GCP project name"
  type = string
}

variable "region" {
  description = "GCP network region"
  type = string
  default = "us-central1"
}
```

## 🚀 Wdrażanie Środowiska Produkcyjnego

### Pojedynczy moduł:
```bash
cd Envs/Production/Database/
terraform init
terraform plan
terraform apply
```

### Całe środowisko:
```bash
# W każdym folderze komponentu w Envs/Production/
for module in Database LoadBalancer VirtualMachine vpc firewall; do
  cd $module
  terraform init && terraform apply -auto-approve
  cd ..
done
```

## 🛡️ Bezpieczeństwo

### Sensitive Variables
Wszystkie hasła są oznaczone jako `sensitive = true`:
- `admin_password`
- `mysql_user_password`

### Credentials Management
- Service account keys przechowywane w folderze `Key/`
- Nie commitowane do repozytorium (dodane do .gitignore)

### Network Security
- Private IP allocation z automatycznym CIDR calculation
- Firewall rules z kontrolowanymi source ranges
- GKE private clusters z authorized networks

## 📈 Stan Projektu

- ✅ **8 działających modułów**
- ✅ **Środowisko produkcyjne skonfigurowane**
- ✅ **Providerzy w wersji 6.13.0**
- 📚 **Dokumentacja na bieżąco**

## 🤝 Współpraca

Jeśli napotkasz problemy lub masz pytania:

- **GitHub Issues**: [Zgłoś problem](https://github.com/Niesiek/gcp-terraform/issues)
- **Wsparcie techniczne**: Skontaktuj się w przypadku problemów

## 📄 Licencja

1. **Darmowe użycie** - kod dostępny za darmo
2. **Referencje mile widziane** - wspomnij o autorze w swojej organizacji
3. **Wsparcie techniczne** - kontakt w przypadku problemów

## 🏷️ Tagi

`terraform` `google-cloud` `gcp` `infrastructure-as-code` `modules` `mysql` `load-balancer` `kubernetes` `vpc` `firewall`

---

*Projekt demonstruje umiejętności pracy z Terraform w środowisku Google Cloud Platform z wykorzystaniem zaawansowanej architektury modułowej.*
