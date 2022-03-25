variable "project" {
  type        = string
  default     = ""
  description = "Project name specific to split group of content, provide for avoid duplicate file name in the same workspace."
}

variable "key" {
  type        = string
  description = "The path of file to write content into it."
}

variable "content" {
  type        = string
  description = "content of file to write into key."
}

variable "main_dir" {
  type        = string
  default     = "../../../.tmp"
  description = "main directory to store all file content structured by this module"
}
