SkinnerPixlee.Views.InstaCollectionsIndex = Backbone.View.extend({
  template: JST['insta_collections/index'],

  className: "container",

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      instaCollections: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  },
});
