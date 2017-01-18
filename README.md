### Summary

When using only the stock Python libraries, creating and deploying AWS Lambda
functions is straightforward. However, when you need a third-party library,
you'll need to package the library and any other dependencies into the
deployment zip. Unfortunately, the documentation on how to do this is sparse
and spread across AWS, StackOverflow, and blogs.

The default AWS AMI image is based on RHEL, so we use a CentOS docker image
to build and package all dependencies. Then, we pull the relevant Python
site packages (ignoring internal Python packages) and the AWS Lambda handler
into a ZIP archive. We complete the process by deploying to AWS Lambda.

### Usage

```
Usage: aws-lambda [OPTIONS] COMMAND [ARGS]...

Options:
  --role TEXT     Role ARN
  --profile TEXT  AWS credential profile
  --bucket TEXT   S3 bucket to upload deployment
  --help          Show this message and exit.

Commands:
  all      Build-package-deploy-run in one step
  build    Build image with dependencies
  deploy   Deploy to AWS Lambda
  package  Create AWS Lambda package
  run      Run deployed AWS Lambda function
```

#### Definitions for subcommand arguments

<dl>
  <dt>FUNCTION</dt>
  <dd>Name of the AWS Lambda function to be invoked by the client.</dd>

  <dt>PACKAGE</dt>
  <dd>A standalone Python source file (aka the AWS Lambda handler). This is where the actual work happens.</dd>

  <dt>METHOD</dt>
  <dd>The entrypoint to the handler. When combined with `PACKAGE`, the combination of `PACKAGE.METHOD` is the name of the handler configured in AWS Lambda.</dd>

  <dt>ROLE</dt>
  <dd>The AWS resource name (ARN) for the role. It can also be defined using the `AWS_ROLE_ARN` environment variable.</dd>

  <dt>BUCKET</dt>
  <dd>The name of the S3 bucket used for deployment. It can also be defined using the `AWS_S3_BUCKET` environment variable.</dd>
</dl>

### Examples

  > AWS_ROLE_ARN=xxxxxxxxxx ./aws-lambda all HelloWorld hello.py execute
