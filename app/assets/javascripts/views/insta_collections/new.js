SkinnerPixlee.Views.InstaCollectionsNew = Backbone.View.extend({
  template: JST['insta_collections/new'],

  className: "container",

  events: {
    "submit form": "postInstaCollection",
  },

  render: function () {
    var renderedContent = this.template({
      collection: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  postInstaCollection: function (event) {
    event.preventDefault();
    debugger;
  }
});
