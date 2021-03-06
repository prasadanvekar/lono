---
title: lono cfn update
reference: true
---

## Usage

    lono cfn update STACK

## Description

Update a CloudFormation stack using the generated template.

## Examples

Let's say we make a simple change to a template, like changing the default InstanceType from `t2.small` to `t2.micro`.  Here's what happens when you run `lono cfn update`

```sh
lono cfn update ec2
```

The output should look similiar to this:

<img src="/img/tutorials/ec2/cfn-update-instance-type.png" alt="Stack Update" class="doc-photo">

Notice that before the update gets performed lono provides a preview of the changes that are about to take place. There are two types of "diffs" in the preview.

1. Source code diff of the templates. This is generated by downloading the current CloudFormation template and comparing it with the locally generated one using `colordiff`.
2. CloudFormation Change Set list of changes. This is generated using [AWS CloudFormation Change Set](https://medium.com/boltops/a-simple-introduction-to-cloudformation-part-4-change-sets-dry-run-mode-c14e41dfeab7) feature.

You are prompted with an "Are you sure?" confirmation before lono continues.

By default, the update command will display a preview of the stack changes before applying the update and prompt to check if you are sure.  If you want to bypass the are you sure prompt, use the `--sure` option.

```
lono cfn update ec2 --sure
```

## Conventions: template and param

Lono follows some [coventions](http://lono.cloud/docs/conventions/) that helps keep the commands short.  We'll go through an example to explain:

Provided that you are in a lono project and have a `my-stack` lono template definition.  To update a stack you can simply run:

    lono cfn update my-stack

The above command will generate and use the template in `output/templates/my-stack.json` and parameters in `output/params/my-stack.txt`.  The template by convention defaults to the name of the stack.  In turn, the params by convention defaults to the name of the template.

Here are examples of overriding the template and params name conventions.

    lono cfn update my-stack --template different1

The template used is `output/templates/different1.json` and the parameters used is `output/params/different1.json`.

    lono cfn update my-stack --param different2

The template used is `output/templates/my-stack.json` and the parameters used is `output/params/different2.json`.

    lono cfn update my-stack --template different3 --param different4

The template used is `output/templates/different3.json` and the parameters used is `output/params/different4.json`.


## Options

```
[--change-set], [--no-change-set]  # Uses generated change set to update the stack.  If false, will perform normal update-stack.
                                   # Default: true
[--diff], [--no-diff]              # Show diff of the source code template changes before continuing.
                                   # Default: true
[--preview], [--no-preview]        # Show preview of the stack changes before continuing.
                                   # Default: true
[--sure], [--no-sure]              # Skips are you sure prompt
[--template=TEMPLATE]              # override convention and specify the template file to use
[--param=PARAM]                    # override convention and specify the param file to use
[--lono], [--no-lono]              # invoke lono to generate CloudFormation templates
                                   # Default: true
[--capabilities=one two three]     # iam capabilities. Ex: CAPABILITY_IAM, CAPABILITY_NAMED_IAM
[--iam], [--no-iam]                # Shortcut for common IAM capabilities: CAPABILITY_IAM, CAPABILITY_NAMED_IAM
[--rollback], [--no-rollback]      # rollback
                                   # Default: true
[--wait], [--no-wait]              # Wait for stack operation to complete.
                                   # Default: true
[--verbose], [--no-verbose]        
[--noop], [--no-noop]              
```

