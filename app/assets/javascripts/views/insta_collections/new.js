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
    var data = $(event.currentTarget).serializeJSON().collection;
    data.begin_time = Date.parse(data.begin_time) / 1000;
    data.end_time   = Date.parse(data.end_time) / 1000;
    this.model.set(data);
    this.model.save({}, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate(
          "collections/" + this.model.id,
          { trigger: true }
        );
      }.bind(this),
      error: function () {
        debugger;
      }
    });
  }
});
