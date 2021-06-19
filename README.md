This is a simple script to download Megadeth guitar tabs from the [Elton Tab Archive](https://www.eltontabs.com/).


It uses the `nokogiri` gem for parsing the URLs and the `down` gem for downloading the actual files from their URLs. There are various formats for each song. This will download only text and PDF files. All files are saved to the folder `./downloads/`.

Run the script
```shell
$ ruby script.rb
```
