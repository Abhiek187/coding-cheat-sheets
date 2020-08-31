# HTML
![HTML Logo](img-html.png)

HTML is the skeleton that creates websites like this. It is a markup language that lets developers insert common items like tables, images, and videos into webpages using a simple tag. A website can exist with just HTML, but it is almost always paired with CSS and JavaScript to add flair and interactivity for users.

## How to Run
Any modern browser should be able to render this file. You can test it out on a computer, tablet, or phone. There are two ways to run this site. One is to directly open `index.html` using Ctrl-O or Cmd-O in a browser. The other way is to run a server in the background. To do that, follow the following steps:

1. Go to the `coding-cheat-sheets` directory (right above this one). The reason we do this is that servers cannot access files in parent directories.
2. On the command line, type `python3 -m http.server <PORT_NUM>` where <PORT_NUM> can be any number from 1024 to 65535. The default is 8000.
3. Go to `localhost:<PORT_NUM>/HTML` in your browser to open `index.html`.

To stop the server, press Ctrl-C or Cmd-C on the command line. This second method will allow the website to be more dynamic. You can have the server handle any requests from the webpage. In our case, it's needed to read `how_to_json.json`.

For more on HTML, check out the [documentation](https://developer.mozilla.org/en-US/docs/Web/HTML).
