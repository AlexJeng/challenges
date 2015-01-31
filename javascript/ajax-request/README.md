## AJAX Request

We provide a JSON data source at: http://api.xxx.com/ajax-test

As you can see, it's a simple 2-d array, served as application/json

Your task is to build a web page which makes an AJAX request to this URL, parses the resulting data and builds a HTML table.
The table should look something like:

    +-------------------+
    |  Animal  |  Legs  |
    +-------------------+
    |  trout   | 0      |
    |  chicken | 2      |
    |  zebra   | 4      |
    |  spider  | 8      |
    +-------------------+

When the header cell "Animal" is clicked on, the table should be sorted
alphabetically on the 1st column and when the header cell "Legs" is clicked on,
the table should be sorted numerically on the 2nd column. Do not use any
library (e.g. jquery.tablesorter.js or equivalent) to implement the table;
please hand-craft it yourself.

The page should work in at least: IE7+, FF3+ & Chrome.

Notes:

1. We strongly encourage the use of JQuery (but if you prefer another library,
   or want to go freestyle, that's your call).

2. As you'll be pulling the data from our site, you'll have to solve the 'same
   origin policy' issue. To make this easy, we support JSONP requests; JQuery's
   support for them will work nicely.

    If you are using `<SCRIPT>` tags to pull the data, you can specify your callback like this:

        http://api.xxx.com/ajax-test?callback=myCallback

    If cross-domain AJAX and JSONP mean nothing to you, you are allowed to paste the response from our API directly to the top of your page as a JS *string* and pretend that you retrieved it dynamically. Points will be deducted if you use a JSON literal instead of a string.

3. For our convenience, please inline everything (i.e. CSS, JS) into a single
   HTML file. You can either host this file yourself and give us a URL, or
   email it to us.

4. Do not spend more than 90 mins in total doing this. If you have spare time,
   you can embellish the table with useful features. For example,
   bi-directional sorting, tool-tips, clever CSS effects, interesting use of
   cookies, etc...

5. If you finish the minimum requirements in under 90 mins feel free to mail in
   your solution so we know how fast you are, and then continue to add features
   and email them in as you complete them.
