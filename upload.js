var fs = require('fs');
var gcloud = require('gcloud');
var storage;

// Or from elsewhere: 
storage = gcloud.storage({
  keyFilename: '../../gs.json',
  projectId: 'nodeos-speed'
});

var bucket = storage.bucket('pre-compiled');

fs.createReadStream('./out.zip').pipe(bucket.file('out.zip').createWriteStream());

