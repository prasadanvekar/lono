---
title: Update the Stack
---

Now is a good time to introduce `lono cfn update` command before moving on. In the previous section, we use the `lono cfn create` command and assumed that the template magically worked the very first time.  In practice, it usually takes a few iterations before you get the CloudFormation template working right.  The CloudFormation development flow more commonly goes:

<img src="/img/tutorials/ec2/dev-flow.png" alt="CloudFormation Development Flow" class="doc-photo">

Let's make a simple change to test out the `lono cfn update` command. We'll chnage the default InstanceType from `t2.small` to `t2.micro` and then run:

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

You'll find the `lono cfn update` command helpful in the sections.

<a id="prev" class="btn btn-basic" href="{% link _docs/tutorials/ec2/cfn-create.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/tutorials/ec2/edit-lono.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>
