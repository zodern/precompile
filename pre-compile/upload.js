var fs = require('fs');
var gcloud = require('gcloud');
var storage;
var args = process.argv.slice(2);

// Or from elsewhere: 
storage = gcloud.storage({
  keyFilename: '../gs.json',
  projectId: 'nodeos-speed'
});


var bucket = storage.bucket('pre-compiled');
console.log('uploading ...')
fs.createReadStream(args[0]).pipe(bucket.file(args[1]).createWriteStream());