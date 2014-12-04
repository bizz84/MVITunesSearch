MVITunesSearch
=======================================================

This project includes some wrapper classes for the iTunes Search API that make it easier to search for apps by developer ID.

Usage
-------------------------------------------------------
A search can be performed by specifying the developer ID and an array of excluded bundle IDs.
This can be handy if you wish load all developer apps apart from the one currently in use.

<pre>
    MVITunesSearch *search = [MVITunesSearch searchWithArtistID:kYourITunesArtistId
                                               exludedBundleIDs:@[ @"com.example.Example" ]
                                                     completion:^(NSArray *searchResults, NSError *error) {

        // Do something with results
     }];
</pre>

Upon completion, an array of MVITunesSearchResults is returned.

<pre>
@interface MVITunesSearchResult : NSObject
@property (copy, nonatomic) NSString *appBundleId;
@property (copy, nonatomic) NSString *appId;
@property (copy, nonatomic) NSString *appURL;
@property (copy, nonatomic) NSString *iconArtworkSize60URL;
@property (copy, nonatomic) NSString *iconArtworkSize100URL;
@property (copy, nonatomic) NSString *iconArtworkSize512URL;
@property (copy, nonatomic) NSDictionary *result;
@end
</pre>

A sample application demonstrating the usage MVITunesSearch is included.

Preview
-------------------------------------------------------
![MVITunesSearch preview](https://github.com/bizz84/MVITunesSearch/raw/master/preview.png "MVITunesSearch preview")

License
-------------------------------------------------------

Copyright (c) 2014 Andrea Bizzotto bizz84@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
