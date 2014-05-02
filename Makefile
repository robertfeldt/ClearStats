clearstats.tar.gz:
	tar cvf clearstats.tar ../clearstats/*
	gzip clearstats.tar

clean:
	rm -rf *.tar *.tar.gz *.tgz
