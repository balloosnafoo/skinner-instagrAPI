SkinnerPixlee.Views.instaCollectionsIndex = Backbone.View.extend({
  template: JST['insta_collections/index'],

  className: "container",

  render: function () {
    var renderedContent = this.template({
      instaCollection: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  },
});
