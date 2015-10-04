# Instagram Collection Maker

## Instructions

The app can be accessed at skinner-pixlee.herokuapp.com. The home page show an
index of collections that have been created, and has a link to the form to
create a new collection.

Requests can also be made by posting to the route
`/api/collections?tag={tag}&begin_time={time_as_int}&end_time={time_as_int}`
and collections can be received in batches of twenty posts through a GET Request
to `/api/collections/:id`. Sent data includes an offset, which can be included
in the next GET request to get the next page.

## Notes

I did the frontend rather than the backend. On the frontend I made a very simple
show page that allows the user to paginate through the collection, as well as
a new page, and an index page.

I would have loved to complete the backend, because if a user requested a collection
involving a common hashtag (e.g. #lol, #nofilter), a large date range, or both,
then the collection takes a lot of time to process. Given more time I would
make it so that enough data to provide the first few pages is collected and returned,
and then the rest is fetched in batches asynchronously in the background.

The next thing that I would do is create a join table so that posts included in
many collections don't need to appear many times in the db. This could drastically
reduce the amount of db space that is required by the app.

I would also spend a bit of time on the styling, as the way that I made it is
about as barebones as you can get.

## Issues

The fact that comments with the target tag that are made after the fact are to
be included makes this very difficult, as api requests aren't sorted by tag time
as defined in the specs, they are sorted by the post's `created_time` field.
This means that to ensure a complete collection of tag times that fall in the
given range, one would have to go through the entire collection (unless comments
are closed at some point, I don't use Instagram, so I'm not sure if this is the
case) and check for recent comments from the user with the tag. This makes
creation of collections with common tags unfeasible if the user has to wait on the
collection to be created (as is the case in my app), so I stopped the search when
I got to post dates that are before the given `begin_time`.

Another issue that didn't seem to be solvable was that a range far in the past
(e.g. May 1, 2008 - May 20, 2008) still requires going through all of the tagged
posts between now and then. This is because the /tags/ api endpoint only listed
two parameters: `max_tag_id` and `min_tag_id`, neither of which seem to convey
any information about time of posting. This is again problematic for the creation
of collections under certain conditions.
