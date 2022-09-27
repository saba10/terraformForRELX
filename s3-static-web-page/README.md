This terraform module can be used to create a simple static webpage using s3 and the output endpoint is accessible to the public. 



Note - Need to configure the aws access and secret keys as env variables 'TF_VAR_aws_access_key' and 'TF_VAR_aws_secret_key' respectively. 



Considerations - 
1.Others in your team should be able to maintain the solution. 
- Published the source code to public github  
- we could make use of of s3 for storing state files. Currently, this section is commented out and if required it can be made use of.

2.How you would measure the quality of your solution?
- Readability - Currently, I have used 3 files - main.tf , outputs.tf and varibales.tf but as the complexity increases, I need to break them into multiple files or use multiple modules.
- Reusable - For example, making use of variables wherever required and by maintaining code in version control, etc
- Secure - Making sure none of the sensitive information such as state file, aws creds, etc are committed into version control

Also, I have planned to make improvements as I get time:)
