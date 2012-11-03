(function($, undefined) {

    var uiPopoverClasses = 'ui-popover ';
    var openPopover = null;

    $.widget("ui.popover", {

// Default options
        options: {
            offsetX: 0,
            offsetY: 0,
            zindex: 1000,
            closeOnEscape: true,
            restrictTabbing: true,
            focusAnchorOnEscape: true,
            arrowPosition: 'center',
            open: null,
            close: null,
            live: false,
            popoverClass: '',
            overlay: false,
            anchor: null,
            buttons: {}
        },

        _create: function() {
            var self = this,
            options = self.options,

            uiPopover = (self.uiPopover = $('<div></div>')).appendTo(document.body).addClass(uiPopoverClasses + options.popoverClass).css({
                zIndex: options.zIndex
            }).hide(),

            uiPopoverContent = (self.uiPopoverContent = self.element.show().addClass('ui-widget-content ' + 'ui-popover-content ' + 'ui-corner-all').appendTo(uiPopover) ),

            uiPopoverArrow = (self.uiPopoverArrow = $('<div></div>')).addClass('ui-popover-arrow').click(function() {
                self.close();
            }).appendTo(uiPopover),

            uiPopoverAnchors = (self.uiPopoverAnchors = $('.popover-control[data-popover="' + self.element.attr('id') + '"]').add(options.anchor)),

            uiPopoverTabs = (self.uiPopoverTabs = uiPopoverContent.find('.tabs'));

// Generate unique ID for event namespacing
            self._id = Math.round(new Date().getTime()) + Math.floor(Math.random() * 11);

            self._isOpen = false;

            self.element.data('popover', self);

            self._setArrowPosition(options.arrowPosition);

            self._createButtons(options.buttons);

// setup callbacks for each popover control in wrapped set & return wrapped set
            if (!options.live) {
                return uiPopoverAnchors.each(function() {
                    $(this).bind('click.' + self._id, function() {
                        if (!$(this).hasClass('ui-state-disabled')) {
                            self.toggle($(this));
                        }
                    }).keypress(function(event) {
                        if (event.which === 13) {
                            $(this).trigger('click');
                            return false;
                        } })
                        .attr('tabIndex',0);
/* .data('popover', self); */
                });
            } else { // live popover
                uiPopoverAnchors.live('click.popover', function() {
                    if (!$(event.target).hasClass('ui-state-disabled')) {
                        self.toggle($(event.target));
                        return false;
                    }
                });
            }

        },

        widget: function() {
            return this.uiPopover;
        },

        isOpen: function() {
            return this._isOpen;
        },

        setAnchor: function( newanchor ) {
            var self = this,
            uiPopoverAnchors = (self.uiPopoverAnchors = newanchor);
            return uiPopoverAnchors.each(function() {
                $(this).bind('click.' + self._id, function() {
                    self.toggle($(this));
                }).keypress(function(event) {
                    if (event.which === 13) {
                        $(this).trigger('click');
                        return false;
                    } })
                    .attr('tabIndex',0);
            });
        },

// toggle a anchor popover. If show set to true do not toggle - always show
        toggle: function($anchor) {
            if (!$anchor) $anchor = this.$_anchor;
            if (this._isOpen) {
                if ($anchor.get(0) != this.$_anchor.get(0)) {
                    this._position($anchor);
                } else {
                    this.close($anchor);
                }
            } else {
                this.open($anchor);
            }
        },

        _calcPosition: function() {

            var self = this,
            options = self.options,
            position = {},
            location = self.location = this.$_anchor.data('popover-location'),
            anchorHeight = this.$_anchor.outerHeight(true),
            anchorWidth = this.$_anchor.outerWidth(true),
            popoverWidth = this.uiPopover.outerWidth(true),
            popoverHeight = this.uiPopover.outerHeight(true),
            arrowSize = parseInt(this.uiPopoverArrow.css('border-top-width')),
            offset = this.$_anchor.offset(),
            anchorOffset = {
                'top': Math.ceil(offset.top),
                'left': Math.ceil(offset.left)
            };

            this.uiPopoverArrow.removeClass('left right top bottom');

            if (this.location == 'right' || this.location == 'left') {
                if (this.location == 'left') {
                    position['left'] = anchorOffset.left - popoverWidth - arrowSize + options.offsetX;
                    this.uiPopoverArrow.addClass('left');
                } else {
                    position['left'] = anchorOffset.left + anchorWidth + arrowSize - options.offsetX;
                    this.uiPopoverArrow.addClass('left');
                }
                if (this.arrowPosition == 'top') {
                    position['top'] = anchorOffset.top - arrowSize + Math.ceil(anchorHeight / 2);
                } else if (this.arrowPosition == 'bottom') {
                    position['top'] = anchorOffset.top - popoverHeight + arrowSize + Math.ceil(anchorHeight / 2);
                } else {
                    position['top'] = anchorOffset.top - Math.ceil(popoverHeight / 2) + Math.ceil(anchorHeight / 2);
                }
            } else {
                if (this.location == 'top') {
                    position['top'] = anchorOffset.top - popoverHeight - arrowSize + options.offsetY;
                    this.uiPopoverArrow.addClass('top');
                } else {
                    position['top'] = anchorOffset.top + anchorHeight + arrowSize - options.offsetY;
                    this.uiPopoverArrow.addClass('bottom');
                }
                if (this.arrowPosition == 'left') {
                    position['left'] = anchorOffset.left - arrowSize + Math.ceil(anchorWidth / 2);
                } else if (this.arrowPosition == 'right') {
                    position['left'] = anchorOffset.left + anchorWidth + arrowSize - popoverWidth;
                } else {
                    position['left'] = anchorOffset.left - Math.ceil(popoverWidth / 2) + Math.ceil(anchorWidth / 2) + Math.ceil(arrowSize);
                }
            }
            position['offtop'] = position['top'];
            position['offleft'] = position['left'];
            return position;
        },


        _createButtons: function(buttons) {
            var self = this,
            hasButtons = false,
            uiPopoverButtonPane = $('<div></div>')
                .addClass(
'ui-popover-buttonpane ' +
'ui-widget-content ' +
'ui-helper-clearfix'
                ),
            uiButtonSet = $( "<div></div>" )
                .addClass( "ui-popover-buttonset" )
                .appendTo( uiPopoverButtonPane );

// if we already have a button pane, remove it
            self.uiPopover.find('.ui-popover-buttonpane').remove();

            if (typeof buttons === 'object' && buttons !== null) {
                $.each(buttons, function() {
                    return !(hasButtons = true);
                });
            }
            if (hasButtons) {
                $.each(buttons, function(name, props) {
                    props = $.isFunction( props ) ?
                        { click: props, text: name } :
                    props;
                    if (typeof props.type === 'undefined') props.type = 'button';
                    var button = $('<button type="'+props.type+'">'+props.text+'</button>')
                        .click(function() {
                            if (typeof props.click !== 'undefined')
                                props.click.apply(self.element[0], arguments);
                        })
                        .appendTo(uiButtonSet);
                    $.each( props, function( key, value ) {
                        if ( key === "click" || key === 'type' ) {
                            return;
                        }
                        button.attr( key, value );
                    });
                    if ($.fn.button) {
                        button.button();
                    }
                });
                uiPopoverButtonPane.insertAfter(self.uiPopoverContent.children(':last'));
            }
        },

        _updatePosition: function() {
            var pos = this._calcPosition();
            this.uiPopover.css({
                'left': pos['left'],
                'top': pos['top'],
                'bottom': 'auto',
                'right': 'auto'
            });
        },

        _getViewportSize: function() {
            var h = $.browser.opera && $.browser.version < '9.5' ? window.innerHeight : $(window).height();
            return [$(window).width(), h];
        },

        _position: function($anchor) {

            this.uiPopover.show();

            var self = this,
            popoverWidth = this.uiPopover.outerWidth(true),
            popoverHeight = this.uiPopover.outerHeight(true),
            popoverOffset = this.uiPopover.offset(),
            pos = undefined,
            scrollTop = ($anchor.css('position') == 'fixed') ? 0 : $(window).scrollTop(),
            scrollLeft = ($anchor.css('position') == 'fixed') ? 0 : $(window).scrollLeft(),
            viewport = this._getViewportSize();
            if (popoverWidth != this._width || popoverHeight != this._height || $anchor.get(0) != this.$_anchor.get(0)) {
                this._width = popoverWidth;
                this._height = popoverHeight;
                this.$_anchor = $anchor;
                this._updatePosition();
            }

            if (1==1) {
                if (this.location == 'top' || this.location == 'bottom') {
                    if (this.location == 'bottom' && (popoverOffset.top - scrollTop + popoverHeight > viewport[1])) {
                        this.location = 'top';
                    }
                    if (this.location == 'top') {
                        pos = this._calcPosition();
                        if (pos['offtop'] - scrollTop < 0) {
                            this.location = 'bottom';
                        }
                    }
                    pos = this._calcPosition();
                    if (pos['offleft'] - scrollLeft + popoverWidth > viewport[0]) {
                        if (this.arrowPosition == 'left') {
                            this._setArrowPosition('center');
                            pos = this._calcPosition();
                        }
                        if (this.arrowPosition == 'center' && (pos['offleft'] - scrollLeft + popoverWidth > viewport[0])) {
                            this._setArrowPosition('right');
                            pos = this._calcPosition();
                        }
                    }
                    if (pos['offleft'] - scrollLeft < 0) {
                        if (this.arrowPosition == 'right') {
                            this._setArrowPosition('center');
                            pos = this._calcPosition();
                        }
                        if (this.arrowPosition == 'center' && (pos['offleft'] - scrollLeft < 0)) {
                            this._setArrowPosition('left');
                            pos = this._calcPosition();
                        }
                    }
                } else {
                    if (this.location == 'right' && (popoverOffset.left - scrollLeft + popoverWidth > viewport[0])) {
                        this.location = 'left';
                    }
                    if (this.location == 'left') {
                        pos = this._calcPosition();
                        if (pos['offleft'] - scrollLeft < 0) {
                            this.location = 'right';
                        }
                    }
                    pos = this._calcPosition();
                    if (pos['offtop'] - scrollTop + popoverHeight > viewport[1]) {
                        if (this.arrowPosition == 'top') {
                            this._setArrowPosition('center');
                            pos = this._calcPosition();
                        }
                        if (this.arrowPosition == 'center' && (pos['offtop'] - scrollTop + popoverHeight > viewport[1])) {
                            this._setArrowPosition('bottom');
                            pos = this._calcPosition();
                        }
                    }
                    if (pos['offtop'] - scrollTop < 0) {
                        if (this.arrowPosition == 'bottom') {
                            this._setArrowPosition('center');
                            pos = this._calcPosition();
                        }
                        if (this.arrowPosition == 'center' && (pos['offtop'] - scrollTop < 0)) {
                            this._setArrowPosition('top');
                            pos = this._calcPosition();
                        }
                    }
                }
                this._updatePosition();
            }

        },

        _setArrowPosition: function(position) {
            this.arrowPosition = position;
            this.uiPopoverArrow.removeClass('ui-popover-arrow-left ui-popover-arrow-right ui-popover-arrow-center ui-popover-arrow-top arrow-bottom').addClass('ui-popover-arrow-' + position);
        },

        _handleEsc: function(event) {
            if (this.options.closeOnEscape && !event.isDefaultPrevented() && event.keyCode && event.keyCode === $.ui.keyCode.ESCAPE) {
                this.close();
                if (this.options.focusAnchorOnEscape) {
                    this.$_anchor.focus();
                }
            }
        },

        _handleOffClick: function(event) {
            var target = event.originalTarget;
            if (!target) {
                target = event.target;
            }
            if (target) {
                try {
                    if (this.options.closeOnEscape && this.uiPopover.get(0) != target && !$.contains(this.uiPopover.get(0), target) && !$.contains(this.$_anchor.get(0), target) && this.$_anchor.get(0) != target && !$(target).parents('.ui-autocomplete').length) {

                        this.close();
                    }
                } catch (err) {}
            }
        },

        _handleWindowResize: function(event) {
            this._position(this.$_anchor);
        },

        _handleWindowScroll: function(event) {

        },


        open: function($anchor) {

            if (this._isOpen) {
                return;
            }

            var self = this,
            options = self.options;

            self.overlay = options.overlay ? new $.ui.dialog.overlay(self) : null;
            self.uiPopover.show();
            self._position($anchor);

            $anchor.addClass('ui-state-active');

// prevent tabbing out of popovers
            if (options.restrictTabbing) {
                self.uiPopover.bind("keydown.ui-popover", function(event) {
                    if (event.keyCode !== $.ui.keyCode.TAB) {
                        return;
                    }
                    var tabbables = $(':tabbable', this),
                    first = tabbables.filter(':first'),
                    last = tabbables.filter(':last');
                    if (event.target === last[0] && !event.shiftKey) {
                        first.focus(1);
                        return false;
                    } else if (event.target === first[0] && event.shiftKey) {
                        last.focus(1);
                        return false;
                    }
                });
            }

            $(document).bind('keydown.' + this._id, $.proxy(this._handleEsc, this));
            $(document).bind('click.' + this._id, $.proxy(this._handleOffClick, this));
            $(window).bind('resize.' + this._id, $.proxy(this._handleWindowResize, this));
            $(window).bind('scroll.' + this._id, $.proxy(this._handleWindowScroll, this));

// set focus to the first tabbable element in the content area
// if there are no tabbable elements, set focus on the modal itself
            $(self.element.find('input:tabbable').get()).eq(0).focus();

            self._isOpen = true;
            self._trigger('open');
            self.$_anchor = $anchor;
            openPopover = self;


        },

        close: function() {

            if (!this._isOpen) {
                return;
            }

            var self = this,
            options = self.options;

            self.uiPopover.hide();self._isOpen = false;

            if ($.isFunction(options.close)) {
                options.close(self.$_anchor);
            }

            $('.ui-widget-overlay').remove();

            self.$_anchor.removeClass('ui-state-active');

            $(document).unbind('keydown.' + this._id, this._handleEsc);
            $(document).unbind('click.' + this._id, this._handleOffClick);
            $(window).unbind('resize.' + this._id, this._handleWindowResize);
            $(window).unbind('scroll.' + this._id, this._handleWindowScroll);

            self._isOpen = false;
            self.uiPopover.trigger('popoverClosed');

        },

        destroy: function() {
            var self = this;

            if (self.overlay) {
                self.overlay.destroy();
            }
            self.close();
self.element
                .removeData('popover');
            self.uiPopover.remove();
            console.log('afterRemove')

            return self;
        },

    });

}(jQuery));
