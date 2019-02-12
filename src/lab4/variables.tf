
variable "inc" {
  default = 6
}

variable "loc" {
    type        = "string"
    description = "Default Azure region"
    default     =   "westeurope"
}

variable "tags" {
    type        = "map"
    default     = {
        source  = "citadel"
        env     = "training"
    }
}

variable "webapplocs" {
  type    = "list"
  default = ["westeurope", "westus2", "westindia"]
}