default: run

clean: 
	find . -name *.mp4

run:
	sh mosaic-concat.all.sh "D:\TeslaCam_Backups"
