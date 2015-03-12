s3:
	s3cmd --rexclude="(git|spec)"  sync . s3://tsuru-confs
	s3cmd setacl --acl-public s3://tsuru-confs/aws_userdata.sh
