file { '/tmp/hello-world.txt' :
	ensure  => file,
	content => "hello world\n"
}
