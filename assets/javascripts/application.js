var displayGrowlMessage, growlTemplate, refreshView, root, triggerViewRefresh;

root = typeof exports !== "undefined" && exports !== null ? exports : this;

root.setAsyncNotifications = function() {
  var url;
  url = $('#notifications').data('url');
  return $.ajax({
    url: url,
    dataType: 'json'
  }).done(function(data) {
    return $.each(data, function(index, name) {
      return subscribeDanthesChannel(name);
    });
  });
};

root.subscribeDanthesChannel = function(name) {
  return Danthes.subscribe(name, function(data, channel) {
    if (data.event_type === 'notification') {
      return displayGrowlMessage(data);
    } else if (data.event_type === 'view_refresh') {
      return triggerViewRefresh(data);
    }
  });
};

displayGrowlMessage = function(data) {
  var growl_data, growl_options;
  growl_data = {
    title: data.title,
    message: data.message
  };
  growl_options = {
    type: data.type,
    delay: data.delay,
    template: growlTemplate(),
    animate: {
      enter: 'animated fadeInRight',
      exit: 'animated fadeOutRight'
    }
  };
  return $.notify(growl_data, growl_options);
};

growlTemplate = function() {
  return '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert" style="padding-bottom: 0px;">' +
      '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
      '<span data-notify="icon"></span> ' +
      '<span data-notify="title">{1}</span> ' +
      '<span data-notify="message">{2}</span>' +
      '<a href="{3}" target="{4}" data-notify="url"></a>' +
    '</div>';
};

triggerViewRefresh = function(data) {
  var context, current_action, current_app_id, current_controller, triggers;
  current_controller = $('body').data('controller');
  current_action = $('body').data('action');
  current_app_id = $('body').data('app-id');
  context = data['context'];
  triggers = data['triggers'];
  if (context.controller === current_controller && context.action === current_action && context.app_id === current_app_id) {
    return $.each(triggers, function(index, trigger) {
      return eval(trigger);
    });
  }
};

refreshView = function(url) {
  return $.ajax({
    url: url,
    dataType: 'script'
  });
};
