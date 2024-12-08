// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"
import Dropdown from "@stimulus-components/dropdown"
import Notification from "@stimulus-components/notification"

application.register('dropdown', Dropdown)
application.register('notification', Notification)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import RemoveController from "./remove_controller"
application.register("remove", RemoveController)

import SidebarController from "./sidebar_controller"
application.register("sidebar", SidebarController)

import SlideOverController from "./slide_over_controller"
application.register("slide-over", SlideOverController)