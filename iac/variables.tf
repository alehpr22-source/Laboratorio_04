variable "POSTGRES_USER" {
  type        = string
  description = "The username for the PostgreSQL database."
  default     = "admin"
}

variable "POSTGRES_PASSWORD" {
  type        = string
  description = "The password for the PostgreSQL database."
  sensitive   = true
  default     = "admin"
}

variable "database_port" {
  type        = map(number)
  description = "The port which the database will listen on for each environment."
}

variable "backend_port" {
  type        = map(number)
  description = "The port which the backend will listen on for each environment."
}

variable "frontend_port" {
  type        = map(number)
  description = "The port which the frontend will listen on for each environment."
}