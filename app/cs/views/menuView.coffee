define (require)->
  $ = require 'jquery'
  _ = require 'underscore'
  marionette = require 'marionette'
  require 'bootstrap'
  mainMenu_template = require "text!templates/mainMenu.tmpl"
  
  class MainMenuView extends marionette.CompositeView
    template: mainMenu_template

    triggers: 
      "mouseup .newFile":     "file:new:mouseup"
      "mouseup .saveFile":    "file:save:mouseup"
      "mouseup .loadFile":    "file:load:mouseup"
      "mouseup .newProject":  "project:new:mouseup"
      "mouseup .settings":    "settings:mouseup"
      "mouseup .undo":        "file:undo:mouseup"
      "mouseup .redo":        "file:redo:mouseup"
      "mouseup .parseCSG"  :  "csg:parserender:mouseup"
    
    #events:
      
    
    constructor:(options)->
      super options
      @app = require 'app'
      
      @on "file:new:mouseup" ,=>
        @app.vent.trigger("fileNewRequest", @)
      @on "file:undo:mouseup" ,=>
        if not  $('#undoBtn').hasClass "disabled"
          @app.vent.trigger("undoRequest", @)
      @on "file:redo:mouseup" ,=>
        if not  $('#redoBtn').hasClass "disabled"
          @app.vent.trigger("redoRequest", @)
      @on "csg:parserender:mouseup" ,=>
        if not  $('#updateBtn').hasClass "disabled"
          @app.vent.trigger("parseCsgRequest", @)
        
      @app.vent.bind "undoAvailable", ->
        $('#undoBtn').removeClass("disabled")
      @app.vent.bind "redoAvailable", ->
        $('#redoBtn').removeClass("disabled")
      @app.vent.bind "undoUnAvailable", ->
        $('#undoBtn').addClass("disabled")
      @app.vent.bind "redoUnAvailable", ->
        $('#redoBtn').addClass("disabled")
      @app.vent.bind "clearUndoRedo", ->
        $('#undoBtn').addClass("disabled")
        $('#redoBtn').addClass("disabled")
      @app.vent.bind "modelChanged", ->
        $('#updateBtn').removeClass("disabled")
      @app.vent.bind "parseCsgDone", ->
          $('#updateBtn').addClass("disabled")
      
      
  return MainMenuView