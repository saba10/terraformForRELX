This terraform module can be used to create a simple static webpage using s3 and the output endpoint is accessible to the public. 


Note - Need to configure the aws access and secret keys as env variables 'TF_VAR_aws_access_key' and 'TF_VAR_aws_secret_key' respectively. 

Considerations - 
1.Other in your team should be able to maintain the solution. 
- Published the source code to public github  
- we can make use of of s3 for storing state files. This section is commented out, and if needed it can be made use of.

2.How you would measure the quality of your solution?
- Easily readable - Currently, I have used 3 files - main.tf , outputs.tf and varibales.tf as it is a simple file, as the complexity, I need to break them into multiple files or use multiple modules.
- Reusable - By making use of variable wherever required and by maintaining in a version control, etc
- Secure - Making sure none of the sensitive information such as state file, aws creds, etc are committed into version control

Also, I have planned to make improvements as I get time:)
