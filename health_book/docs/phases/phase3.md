# Phase 3: Newsfeed and Search (2 days)

## Rails
### Models
* NewsfeedItem


### Controllers
* Api::NewsfeedItemsController (create, destroy, index, show, update)

### Views
* newsfeedItems/index.json.jbuilder
* newsfeedItems/show.json.jbuilder

## Flux
### Views (React Components)
* NewsfeedIndex

### Stores
* Newsfeed

### Actions
* ApiActions.receiveAllItems
* ApiActions.receiveSingleItem
* ApiActions.deleteItem

### ApiUtil
* ApiUtil.fetchAllItems
* ApiUtil.fetchSingleItem
* ApiUtil.createItem
* ApiUtil.editItem
* ApiUtil.destroyItem

## Gems/Libraries
