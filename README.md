# terraform-provider-quantum

A custom provider for terraform.

![Coveo](https://img.shields.io/badge/Coveo-awesome-f58020.svg)
[![Build Status](https://travis-ci.org/coveo/terraform-provider-quantum.svg?branch=master)](https://travis-ci.org/coveo/terraform-provider-quantum)
[![Go Report Card](https://goreportcard.com/badge/github.com/coveo/terraform-provider-quantum)](https://goreportcard.com/report/github.com/coveo/terraform-provider-quantum)

## Installation

1. Download the latest [release](github.com/coveo/terraform-provider-quantum/releases) for your platform
2. rename the file to `terraform-provider-quantum`
3. Copy the file to the same directory as terraform `dirname $(which terraform)` is installed

## Usage

### quantum_list_files

#### Example Usage

Returns a list of files from a directory

```hcl
data "quantum_list_files" "data_files" {
  folders   = ["./data"]
  patterns  = ["*.txt", "*.doc*"]
  recursive = true
}
```

The output will look like this:

```sh
data.quantum_list_files.data_files.files = ["./data/file1.txt", "./data/file2.docx"]
```

#### Argument Reference

- `folders` - (Optional) - The source list for folders
- `patterns` - (Optional) - The patterns to match files, uses [golang's filepath.Match](http://godoc.org/path/filepath#Match)
- `recursive` - (Optional) - Default `false`, walk directory recursively

#### Attributes Reference

- `files` - The list of matched files

### quantum_password

This resource will generate a password with lowercase, uppercase, numbers and special characters mathing the specified `length`. It will also rotate the password every `'n'` days based on the `expires_in_days` attribute.

#### Example Usage

Generates a rnadom password to be used by other resources

```hcl
resource "quantum_password" "rds_backup_db_password" {
    length          = 10
    expires_in_days = 90
}
```

The output will look like this:

```sh
+ quantum_password.rds_backup_db_password
    created_at:      "<computed>"
    expires_in_days: "90"
    password:        "<computed>"
```

#### Argument Reference

- `length`          - (Optional) - Password length [default `20`]
- `expires_in_days` - (Optional) - Number of days before a new password gets generated. [default `0`]

> An `expires_in_days` set to `0` means the password expires on each run

#### Attributes Reference

- `password` - Attribute to use in your other resources to set the password


> Note that on *quantum_password* attribute change, you need to run `apply` twice to get the new password propagated to dependant resources. ([Comment on this behavior](https://github.com/hashicorp/terraform/issues/1123#issuecomment-77442647))


## Develop

```sh
go get github.com/coveo/terraform-provider-quantum
cd $GOPATH/src/github.com/coveo/terraform-provider-quantum
go get ./...
$EDITOR .
```