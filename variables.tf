# AWS
variable "aws_region" {
  description = "Região da AWS para os resources.."
  type        = string
  default     = "us-east-1"
}
variable "aws_profile" {
  description = "AWS Profile"
  type        = string
  default     = "default"
}

# S3
variable "bucket_name" {
  description = "Name of the S3 bucket (unique across AWS)."
  type        = string
}
variable "website_files_path" {
  description = "Path to website files folder."
  type        = string
}
variable "website_index_file" {
  description = "Name for index file."
  type        = string
  default     = "index.html"
}
variable "website_error_file" {
  description = "Nome do Bucket onde são hospedados os arquivos relacionados à aplicação."
  type        = string
  default     = "error.html"
}
variable "bucket_tags" {
  type        = map(string)
  description = "Bucket tags."
  default     = {
    project = "MyWebsite"
  }

}