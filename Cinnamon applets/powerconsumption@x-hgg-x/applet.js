const PopupMenu = imports.ui.popupMenu;
const Mainloop = imports.mainloop;
const Applet = imports.ui.applet;
const Settings = imports.ui.settings;
const GLib = imports.gi.GLib;

function PowerConsumptionApplet(metadata, orientation, instance_id) {
  this._init(metadata, orientation, instance_id);
}

PowerConsumptionApplet.prototype = {
  __proto__: Applet.TextApplet.prototype,

  _init: function(metadata, orientation, instance_id) {
    Applet.TextApplet.prototype._init.call(this, orientation, instance_id);

    this.isLooping = true;
    this.state = {};

    this.settings = new Settings.AppletSettings(this.state, metadata.uuid, instance_id);
    this.settings.bindProperty(Settings.BindingDirection.IN, 'interval', 'interval');

    // Create the popup menu
    this.menuManager = new PopupMenu.PopupMenuManager(this);
    this.menu = new Applet.AppletPopupMenu(this, orientation);
    this.menuManager.addMenu(this.menu);

    this.set_applet_tooltip('Power Consumption');

    this.updatePower();
    this.loopId = Mainloop.timeout_add(this.state.interval, () => this.updatePower());
  },

  on_applet_clicked: function() {
    this.buildMenu(this.menuItems);
    this.menu.toggle();
  },

  on_applet_removed_from_panel: function() {
    Mainloop.source_remove(this.loopId);
    this.loopId = 0;
    this.isLooping = false;
    this.settings.finalize();
  },

  buildMenu: function() {
    this.menu.removeAll();
    let isOpen = this.menu.isOpen;
    let section = new PopupMenu.PopupMenuSection();
    let item = new PopupMenu.PopupMenuItem("Power consumption : " + this.title);

    section.addMenuItem(item);
    this.menu.addMenuItem(section);
    if (isOpen) {
      this.menu.open();
    }
  },

  updatePower: function() {
    if (!this.isLooping) {
      return false;
    }

    let is_AC = GLib.spawn_command_line_sync('acpi -a')[1].toString();

    if (is_AC.includes('on-line')) {
      this.title = "";
    }
    else {
      this.title = GLib.spawn_command_line_sync('.local/share/cinnamon/applets/powerconsumption@x-hgg-x/power.sh')[1].toString();
    }

    if (this._applet_label.text !== this.title) {
      this.set_applet_label(this.title);
    }

    return true;
  }
};

function main(metadata, orientation, instance_id) {
  return new PowerConsumptionApplet(metadata, orientation, instance_id);
}
