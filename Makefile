s3:
	s3cmd --rexclude="(git|spec)"  sync . s3://tsuru-confs
