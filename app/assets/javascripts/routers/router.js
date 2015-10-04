SkinnerPixlee.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.instaCollections = options.instaCollections;
  },

  routes: {
    "": "instaCollectionsNew",
    "collections": "instaCollectionsIndex",
    "collections/new": "instaCollectionsNew",
    "collections/:id": "instaCollectionsShow",
  },

  instaCollectionsShow: function (id) {
    var instaCollection = this.instaCollections.getOrFetch(id);
    var view = new SkinnerPixlee.Views.InstaCollectionsShow({
      model: instaCollection,
      collection: this.instaCollections,
    });

    this._swapView(view);
  },

  instaCollectionsNew: function () {
    var view = new SkinnerPixlee.Views.InstaCollectionsNew({
      model: new SkinnerPixlee.Models.InstaCollection(),
      collection: this.instaCollections
    });

    this._swapView(view);
  },

  instaCollectionsIndex: function () {
    this.instaCollections.fetch();
    var view = new SkinnerPixlee.Views.InstaCollectionsIndex({
      collection: this.instaCollections
    });

    this._swapView(view);
  },

  _swapView: function (view) {
    this._view && this._view.remove();
    this._view = view;
    this.$rootEl.html(view.render().$el);
  },
});
