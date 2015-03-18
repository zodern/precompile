var fs = require('fs');
var gcloud = require('gcloud');
var storage;

// Or from elsewhere: 
storage = gcloud.storage({
  keyFilename: '../gs.json',
  projectId: 'nodeos-speed'
});

var bucket = storage.bucket('pre-compiled');
console.log('uploading ...')
fs.createReadStream('./out.tar.xz').pipe(bucket.file('out.tar.xz').createWriteStream());