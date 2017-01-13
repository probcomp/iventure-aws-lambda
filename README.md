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
Usage: aws-lambda [OPTIONS] FUNCTION PACKAGE METHOD ROLE

Options:
  --profile TEXT     AWS credential profile
  --tag TEXT         Tag for generated Docker image
  --timeout INTEGER  Timeout for AWS Lambda function (seconds)
  --memory INTEGER   Maximum memory size for AWS Lambda function (MB)
  --help             Show this message and exit.

FUNCTION is the name of the AWS Lambda function to be invoked by the client.

PACKAGE is a standalone Python source file (aka the AWS Lambda handler). This
is where the actual work happens.

METHOD is the entrypoint to the handler. When combined with PACKAGE, the
combination of PACKAGE.METHOD is the name of the handler configured in AWS
Lambda.

ROLE can also be defined using the AWS_ROLE_ARN environment variable.
```

### Examples

  > AWS_ROLE_ARN=xxxxxxxxxx ./aws-lambda HelloWorld hello.py execute
