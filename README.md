# delete-old-ebs-snapshots

Straight forward and easily extensible Ruby (1.9.3+) script to delete AWS snapshots older than `X` days and/or matching a description regular expression. There are no bells and whistles.

## Prerequisites

- Ruby 1.9.3 or later
- Amazon's [AWS suite of command line tools](http://aws.amazon.com/cli/) (or the old Java-based ones found on older AMIs)

There is no reliance on external gems so no special Ruby environment is required in order to use this script.

## Installation

Just copy the contents of [`bin/delete-old-ebs-snapshots`](https://raw.githubusercontent.com/cfeduke/delete-old-ebs-snapshots/master/bin/delete-old-ebs-snapshots) to a file on disk, set it `+x` and use.

## Usage

```
Usage: delete-old-ebs-snapshots --older-than-days DAYS [--description REGEX] 
       [--interactive]

    -o, --older-than-days DAYS       Older than DAYS days (from today)
    -d, --description REGEX          Ruby compliant regular expression to filter the description against
    -i, --interactive                Prompt before deleting each eligible snapshot
    -A, --args ARGS                  Arguments to pass to AWS CLI tools

    -h, --help                       Display this screen
```

As this script uses the AWS CLI any of the environment variables set for the host shell process invoking the script will be passed into the `aws` command (or alternatively `ec2-describe-snapshots` and `ec2-delete-snapshot` commands). Optionally additional command line switches, like `--region` may be passed to these child processes with the `-A` switch, e.g., `-A"--region=us-west-1"`.

## Development

There are tests to cover the classes defined within the script, though there are no tests around the CLI switches or main execution. 

Most extensions would be adding new filter predicates with accompanying OptParse switches, a very straight forward exercise.

