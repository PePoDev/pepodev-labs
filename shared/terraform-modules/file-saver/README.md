# File Saver

Terraform module to create file into structured folder for easy of use.

## Structured Directory

```terminal
[Main Dir]
└── workspace-name
    ├── project-name
    |   └── key
    └── key (if not specific project name)
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content"></a> [content](#input\_content) | content of file to write into key. | `string` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The path of file to write content into it. | `string` | n/a | yes |
| <a name="input_main_dir"></a> [main\_dir](#input\_main\_dir) | main directory to store all file content structured by this module | `string` | `"../../../.tmp"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name specific to split group of content, provide for avoid duplicate file name in the same workspace. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_filename"></a> [filename](#output\_filename) | File path that created in structure directory by this module |
