# blacklight_search_within

This is ALPHA software!

Add internal object search to Blacklight.

## Description

This modifies Blacklight to have two levels of search.

* Coarse search: the search box on index pages restricts results to documents marked "coarse".

* Search within: the search box on show pages restricts results to documents marked "related" to the current document.

## Requirements

Your Solr documents must have two fields indicating coarseness and clustering.  The default required
fields are:

* `compound_object_broad_b`: documents are considered
"coarse" if this is true
* `parent_id_s`: documents with the same value of this field are clustered together for the
purposes of the search within feature.

## Installation

### Blacklight 5

Add to your application's Gemfile:

```
gem "blacklight_search_within", :git => "https://github.com/uklibraries/blacklight_search_within.git"
```

then run `bundle install`.

### Configuration

All configuration takes place in the `configure_blacklight` block of your
application's Catalog controller.

* config.index.coarse_field: name of "coarse" field
* config.show.fine_field: name of "fine" field

### Views

This overrides the `_show_sidebar` view.  If you are also overriding this
view, please make sure you include the line

```
<%= render :partial => 'search_within_form' %>
```

somewhere in your show view.

## TODO

* [ ] Update README.

* [ ] Fix search history.

* [ ] Add tests.

* [ ] Release proper gem.
