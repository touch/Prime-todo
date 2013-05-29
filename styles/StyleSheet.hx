/*
 * Copyright (c) 2010, The prime Project Contributors
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE prime PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE PRIMVC PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 *
 *
 * Authors:
 *  Ruben Weijers	<ruben @ onlinetouch.nl>
 */
package ;
 import prime.gui.styling.LayoutStyleFlags;
 import prime.gui.styling.StyleChildren;
 import prime.gui.styling.StyleBlockType;
 import prime.gui.styling.StyleBlock;
 import prime.types.Number;
 import prime.gui.components.skins.ButtonLabelSkin;
 import prime.core.geom.Box;
 import prime.core.geom.Corners;
 import prime.core.geom.space.Horizontal;
 import prime.core.geom.space.Vertical;
 import prime.gui.behaviours.layout.ClippedLayoutBehaviour;
 import prime.gui.behaviours.scroll.ShowScrollbarsBehaviour;
 import prime.gui.components.skins.BasicPanelSkin;
 import prime.gui.components.skins.ButtonIconLabelSkin;
 import prime.gui.components.skins.ButtonIconSkin;
 import prime.gui.components.skins.InputFieldSkin;
 import prime.gui.components.skins.SlidingToggleButtonSkin;
 import prime.gui.effects.MoveEffect;
 import prime.gui.graphics.borders.CapsStyle;
 import prime.gui.graphics.borders.JointStyle;
 import prime.gui.graphics.borders.SolidBorder;
 import prime.gui.graphics.fills.SolidFill;
 import prime.gui.graphics.shapes.RegularRectangle;
 import prime.layout.algorithms.float.HorizontalFloatAlgorithm;
 import prime.layout.algorithms.float.VerticalFloatAlgorithm;
 import prime.layout.algorithms.RelativeAlgorithm;
 import prime.layout.RelativeLayout;
 import prime.gui.styling.EffectsStyle;
 import prime.gui.styling.GraphicsStyle;
 import prime.gui.styling.LayoutStyle;
 import prime.gui.styling.StatesStyle;
 import prime.gui.styling.StyleBlock;
 import prime.gui.styling.StyleBlockType;
 import prime.gui.styling.TextStyle;
 import prime.gui.text.TextAlign;
 import prime.gui.text.TextTransform;



/**
 * This class is a template for generating UIElementStyle classes
 */
class StyleSheet extends StyleBlock
{
	public function new ()
	{
		super(0, StyleBlockType.specific);
		elementChildren		= new ChildrenList();
		styleNameChildren	= new ChildrenList();
		idChildren			= new ChildrenList();
		
		
		var styleBlock0 = new StyleBlock(72, StyleBlockType.element, new GraphicsStyle(56, null, null, new RegularRectangle(), null, null, true, 1));
		this.elementChildren.set('prime.gui.display.IDisplayObject', styleBlock0);
		var styleBlock1 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(128, null, null, null, null, function (a) { return new ClippedLayoutBehaviour(a); }));
		styleBlock1.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('prime.gui.core.UIWindow', styleBlock1);
		var styleBlock2 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(8, null, null, new RegularRectangle()));
		styleBlock2.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('prime.gui.core.UIGraphic', styleBlock2);
		var styleBlock3 = new StyleBlock(0x00081A, StyleBlockType.element, null, new LayoutStyle(8, null, null, null, function () { return new VerticalFloatAlgorithm(Vertical.top, Horizontal.left); }, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock3.setInheritedStyles(null, styleBlock0);
		var styleBlock4 = new StyleBlock(26, StyleBlockType.element, null, new LayoutStyle(0x000300, null, null, null, null, 1, 1, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock4.setInheritedStyles(null, styleBlock0, null, styleBlock3);
		var hash5 = new Hash();
		hash5.set('prime.gui.components.ListView', styleBlock4);
		var styleBlock6 = new StyleBlock(26, StyleBlockType.element, null, new LayoutStyle(0x000300, null, null, null, null, 1, 1, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock6.setInheritedStyles(null, styleBlock4, null, styleBlock3);
		hash5.set('prime.gui.components.SelectableListView', styleBlock6);
		styleBlock3.setChildren(null, null, hash5);
		this.elementChildren.set('prime.gui.components.ListHolder', styleBlock3);
		var styleBlock7 = new StyleBlock(0x000C7A, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(-1431655681), null, null, function () { return new ButtonLabelSkin(); }), new LayoutStyle(8, null, null, null, function () { return new HorizontalFloatAlgorithm(Horizontal.center, Vertical.center); }, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648), new TextStyle(7, 10, 'Arial', false, -1, null, null, Number.FLOAT_NOT_SET, null, null, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648));
		styleBlock7.setInheritedStyles(null, styleBlock0);
		var styleBlock8 = new StyleBlock(26, StyleBlockType.element, null, new LayoutStyle(0x000100, null, null, null, null, LayoutStyleFlags.FILL, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock8.setInheritedStyles(null, styleBlock0, null, styleBlock7);
		var hash9 = new Hash();
		hash9.set('prime.gui.core.UITextField', styleBlock8);
		styleBlock7.setChildren(null, null, hash9);
		var styleBlock10 = new StyleBlock(72, StyleBlockType.elementState, new GraphicsStyle(2, new SolidFill(-5592321)));
		styleBlock10.setInheritedStyles(null, null, null, styleBlock7);
		var intHash11 = new IntHash();
		intHash11.set(2, styleBlock10);
		styleBlock7.states = new StatesStyle(2, intHash11);
		var styleBlock12 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(5, null, new SolidBorder(new SolidFill(255), 1, false, CapsStyle.NONE, JointStyle.ROUND, false), null, function () { return new InputFieldSkin(); }));
		styleBlock12.setInheritedStyles(null, styleBlock7);
		this.elementChildren.set('prime.gui.components.InputField', styleBlock12);
		var styleBlock13 = new StyleBlock(42, StyleBlockType.element, null, null, new TextStyle(3, 12, 'Verdana', false, null, null, null, Number.FLOAT_NOT_SET, null, null, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648));
		styleBlock13.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('prime.gui.components.Label', styleBlock13);
		var styleBlock14 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(8, null, null, new RegularRectangle()));
		styleBlock14.setInheritedStyles(null, styleBlock2);
		this.elementChildren.set('prime.gui.components.Image', styleBlock14);
		this.elementChildren.set('prime.gui.components.Button', styleBlock7);
		var styleBlock15 = new StyleBlock(90, StyleBlockType.element, new GraphicsStyle(129, null, null, null, null, function (a) { return new ShowScrollbarsBehaviour(a); }), new LayoutStyle(8, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock15.setInheritedStyles(null, styleBlock12);
		this.elementChildren.set('prime.gui.components.TextArea', styleBlock15);
		var styleBlock16 = new StyleBlock(90, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(-1)), new LayoutStyle(8, null, null, null, function () { return new RelativeAlgorithm(); }, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock16.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('prime.gui.components.SliderBase', styleBlock16);
		var styleBlock17 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(0x212121FF)));
		styleBlock17.setInheritedStyles(null, styleBlock16);
		this.elementChildren.set('prime.gui.components.ScrollBar', styleBlock17);
		var styleBlock18 = new StyleBlock(90, StyleBlockType.element, new GraphicsStyle(1, null, null, null, function () { return new ButtonIconLabelSkin(); }), new LayoutStyle(32, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, 40, -2147483648, -2147483648, -2147483648));
		styleBlock18.setInheritedStyles(null, styleBlock7);
		this.elementChildren.set('prime.gui.components.ComboBox', styleBlock18);
		var styleBlock19 = new StyleBlock(0x00204A, StyleBlockType.element, new GraphicsStyle(1, null, null, null, function () { return new BasicPanelSkin(); }));
		styleBlock19.setInheritedStyles(null, styleBlock0);
		var styleBlock20 = new StyleBlock(72, StyleBlockType.id, new GraphicsStyle(1, null, null, null, function () { return new ButtonIconSkin(); }));
		styleBlock20.setInheritedStyles(null, null, null, styleBlock19);
		var hash21 = new Hash();
		hash21.set('closeBtn', styleBlock20);
		styleBlock19.setChildren(hash21);
		this.elementChildren.set('prime.gui.components.Panel', styleBlock19);
		var styleBlock22 = new StyleBlock(0x00085A, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(0x111111FF)), new LayoutStyle(0x000108, null, null, null, function () { return new HorizontalFloatAlgorithm(Horizontal.center, Vertical.center); }, 1, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock22.setInheritedStyles(null, styleBlock0);
		var styleBlock23 = new StyleBlock(0x00047E, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(-858993409), null, null, function () { return new prime.gui.components.skins.ButtonLabelSkin(); }), new LayoutStyle(0x003000, null, new Box(4, 6, 4, 6), new Box(5, 5, 5, 5), null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648), new TextStyle(5, 10, null, false, 0x333333FF, null, null, Number.FLOAT_NOT_SET, null, null, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648));
		styleBlock23.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock22);
		var styleBlock24 = new StyleBlock(76, StyleBlockType.elementState, new GraphicsStyle(2, new SolidFill(-1)));
		styleBlock24.setInheritedStyles(null, null, styleBlock10, styleBlock23);
		var intHash25 = new IntHash();
		intHash25.set(2, styleBlock24);
		var styleBlock26 = new StyleBlock(72, StyleBlockType.elementState, new GraphicsStyle(2, new SolidFill(-1)));
		styleBlock26.setInheritedStyles(null, null, null, styleBlock23);
		intHash25.set(0x000800, styleBlock26);
		styleBlock23.states = new StatesStyle(0x000802, intHash25);
		var hash27 = new Hash();
		hash27.set('prime.gui.components.Button', styleBlock23);
		styleBlock22.setChildren(null, null, hash27);
		this.elementChildren.set('prime.gui.components.DebugBar', styleBlock22);
		var styleBlock28 = new StyleBlock(0x00205A, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(-858993409)), new LayoutStyle(8, null, null, null, function () { return new VerticalFloatAlgorithm(Vertical.top, Horizontal.center); }, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock28.setInheritedStyles(null, styleBlock1);
		var styleBlock29 = new StyleBlock(56, StyleBlockType.id, null, new LayoutStyle(0x000100, null, null, null, null, 1, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648), new TextStyle(67, 50, 'Verdana', false, null, null, null, Number.FLOAT_NOT_SET, TextAlign.CENTER, null, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648));
		styleBlock29.setInheritedStyles(null, null, null, styleBlock28);
		var hash30 = new Hash();
		hash30.set('title', styleBlock29);
		var styleBlock31 = new StyleBlock(24, StyleBlockType.id, null, new LayoutStyle(0x003000, null, new Box(10, 10, 10, 10), new Box(0, 0, 5, 0), null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock31.setInheritedStyles(null, null, null, styleBlock28);
		hash30.set('btnAddTask', styleBlock31);
		var styleBlock32 = new StyleBlock(0x000438, StyleBlockType.id, null, new LayoutStyle(0x001100, null, null, new Box(0, 0, 5, 0), null, 1, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648), new TextStyle(67, 40, 'Verdana', false, null, null, null, Number.FLOAT_NOT_SET, TextAlign.LEFT, null, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648));
		styleBlock32.setInheritedStyles(null, null, null, styleBlock28);
		var styleBlock33 = new StyleBlock(40, StyleBlockType.idState, null, null, new TextStyle(3, 40, 'Verdana', false, null, null, null, Number.FLOAT_NOT_SET, null, null, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648));
		styleBlock33.setInheritedStyles(null, null, null, styleBlock32);
		var intHash34 = new IntHash();
		intHash34.set(2, styleBlock33);
		styleBlock32.states = new StatesStyle(2, intHash34);
		hash30.set('input', styleBlock32);
		var styleBlock35 = new StyleBlock(0x000858, StyleBlockType.id, new GraphicsStyle(130, new SolidFill(-5592321), null, null, null, function (a) { return new ShowScrollbarsBehaviour(a); }), new LayoutStyle(0x000209, null, null, null, function () { return new VerticalFloatAlgorithm(Vertical.top, Horizontal.left); }, Number.FLOAT_NOT_SET, 0.65, 0x000320, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock35.setInheritedStyles(null, null, null, styleBlock28);
		var styleBlock36 = new StyleBlock(30, StyleBlockType.element, null, new LayoutStyle(0x001000, null, null, new Box(3, 3, 3, 3), null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock36.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock35);
		var hash37 = new Hash();
		hash37.set('prime.gui.components.Button', styleBlock36);
		styleBlock35.setChildren(null, null, hash37);
		hash30.set('listView', styleBlock35);
		var styleBlock38 = new StyleBlock(0x000818, StyleBlockType.id, null, new LayoutStyle(0x000108, null, null, null, function () { return new HorizontalFloatAlgorithm(Horizontal.center, Vertical.center); }, 1, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock38.setInheritedStyles(null, null, null, styleBlock28);
		var styleBlock39 = new StyleBlock(30, StyleBlockType.element, null, new LayoutStyle(0x001000, null, null, new Box(5, 5, 5, 5), null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock39.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock38);
		var hash40 = new Hash();
		hash40.set('prime.gui.components.Button', styleBlock39);
		styleBlock38.setChildren(null, null, hash40);
		hash30.set('optionsHolder', styleBlock38);
		styleBlock28.setChildren(hash30);
		this.elementChildren.set('prime.examples.todoapp.TodoGUI', styleBlock28);
		var styleBlock41 = new StyleBlock(26, StyleBlockType.element, null, new LayoutStyle(8, null, null, null, function () { return new HorizontalFloatAlgorithm(); }, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock41.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('prime.examples.todoapp.ListRow', styleBlock41);
		var styleBlock42 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(36, null, new SolidBorder(new SolidFill(-16711681), 3, false, CapsStyle.NONE, JointStyle.ROUND, false), null, null, null, null, 0.7));
		var styleBlock43 = new StyleBlock(0x000808, StyleBlockType.styleName);
		styleBlock42.setInheritedStyles(null, styleBlock0, null, styleBlock43);
		var hash44 = new Hash();
		hash44.set('prime.gui.core.UIComponent', styleBlock42);
		styleBlock43.setChildren(null, null, hash44);
		this.styleNameChildren.set('debug', styleBlock43);
		var styleBlock45 = new StyleBlock(30, StyleBlockType.element, null, new LayoutStyle(0x000300, null, null, null, null, 0, 1, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		var styleBlock46 = new StyleBlock(0x000818, StyleBlockType.styleName, null, new LayoutStyle(34, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, 4, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, 30, -2147483648, -2147483648, -2147483648));
		styleBlock45.setInheritedStyles(null, styleBlock0, styleBlock2, styleBlock46);
		var hash47 = new Hash();
		hash47.set('prime.gui.core.UIGraphic', styleBlock45);
		var styleBlock48 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(0x666666FF)), new LayoutStyle(7, new RelativeLayout(-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 6, 15, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock48.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock46);
		hash47.set('prime.gui.components.Button', styleBlock48);
		styleBlock46.setChildren(null, null, hash47);
		this.styleNameChildren.set('horizontalSlider', styleBlock46);
		var styleBlock49 = new StyleBlock(30, StyleBlockType.element, null, new LayoutStyle(0x000304, new RelativeLayout(-2147483648, -2147483648, 0, -2147483648, -2147483648, -2147483648), null, null, null, 1, 0, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		var styleBlock50 = new StyleBlock(0x000818, StyleBlockType.styleName, null, new LayoutStyle(129, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 4, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, 30, -2147483648));
		styleBlock49.setInheritedStyles(null, styleBlock0, styleBlock2, styleBlock50);
		var hash51 = new Hash();
		hash51.set('prime.gui.core.UIGraphic', styleBlock49);
		var styleBlock52 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(0x666666FF)), new LayoutStyle(135, new RelativeLayout(-2147483648, -2147483648, -2147483648, -2147483648, 0, -2147483648), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 15, 6, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, 15, -2147483648));
		styleBlock52.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock50);
		hash51.set('prime.gui.components.Button', styleBlock52);
		styleBlock50.setChildren(null, null, hash51);
		this.styleNameChildren.set('verticalSlider', styleBlock50);
		var styleBlock53 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(0x212121FF)), new LayoutStyle(39, new RelativeLayout(-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 6, 9, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, 15, -2147483648, -2147483648, -2147483648));
		var styleBlock54 = new StyleBlock(0x000818, StyleBlockType.styleName, null, new LayoutStyle(2, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, 2, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock53.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock54);
		var hash55 = new Hash();
		hash55.set('prime.gui.components.Button', styleBlock53);
		styleBlock54.setChildren(null, null, hash55);
		this.styleNameChildren.set('horizontalScrollBar', styleBlock54);
		var styleBlock56 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(0x212121FF)), new LayoutStyle(135, new RelativeLayout(-2147483648, -2147483648, -2147483648, -2147483648, 0, -2147483648), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 9, 6, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, 15, -2147483648));
		var styleBlock57 = new StyleBlock(0x000818, StyleBlockType.styleName, null, new LayoutStyle(1, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 2, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock56.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock57);
		var hash58 = new Hash();
		hash58.set('prime.gui.components.Button', styleBlock56);
		styleBlock57.setChildren(null, null, hash58);
		this.styleNameChildren.set('verticalScrollBar', styleBlock57);
		var styleBlock59 = new StyleBlock(0x00085A, StyleBlockType.element, new GraphicsStyle(128, null, null, null, null, function (a) { return new ShowScrollbarsBehaviour(a); }), new LayoutStyle(0x00A3CB, null, new Box(0, 0, 0, 0), null, function () { return new VerticalFloatAlgorithm(Vertical.top, Horizontal.left); }, Number.EMPTY, Number.EMPTY, Number.EMPTY, Number.EMPTY, -2147483648, 20, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, 60, 0x0001F4));
		var styleBlock60 = new StyleBlock(0x000848, StyleBlockType.styleName, new GraphicsStyle(0x000106, new SolidFill(-101058049), new SolidBorder(new SolidFill(0x707070FF), 1, false, CapsStyle.NONE, JointStyle.ROUND, false), null, null, null, null, Number.FLOAT_NOT_SET, null, null, new Corners(10, 10, 10, 10)));
		styleBlock59.setInheritedStyles(null, styleBlock0, null, styleBlock60);
		var styleBlock61 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(1, null, null, null, function () { return new ButtonIconLabelSkin(); }), new LayoutStyle(0x011100, null, null, new Box(0, 0, 0, 0), null, 1, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648, 1));
		styleBlock61.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock59);
		var hash62 = new Hash();
		hash62.set('prime.gui.components.Button', styleBlock61);
		styleBlock59.setChildren(null, null, hash62);
		var hash63 = new Hash();
		hash63.set('prime.gui.components.SelectableListView', styleBlock59);
		styleBlock60.setChildren(null, null, hash63);
		this.styleNameChildren.set('comboList', styleBlock60);
		var styleBlock64 = new StyleBlock(88, StyleBlockType.id, new GraphicsStyle(2, new SolidFill(-16776961)), new LayoutStyle(4, new RelativeLayout(1, -2147483648, 1, -2147483648, -2147483648, -2147483648), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		var styleBlock65 = new StyleBlock(0x002858, StyleBlockType.styleName, new GraphicsStyle(0x000103, new SolidFill(0x666666FF), null, null, function () { return new SlidingToggleButtonSkin(); }, null, null, Number.FLOAT_NOT_SET, null, null, new Corners(5, 5, 5, 5)), new LayoutStyle(3, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 50, 30, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648));
		styleBlock64.setInheritedStyles(null, null, null, styleBlock65);
		var hash66 = new Hash();
		hash66.set('onBg', styleBlock64);
		var styleBlock67 = new StyleBlock(40, StyleBlockType.id, null, null, new TextStyle(4, -2147483648, null, false, -1, null, null, Number.FLOAT_NOT_SET, null, null, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648));
		styleBlock67.setInheritedStyles(null, null, null, styleBlock65);
		hash66.set('onLabel', styleBlock67);
		var styleBlock68 = new StyleBlock(216, StyleBlockType.id, new GraphicsStyle(0x00010A, new SolidFill(-1), null, new RegularRectangle(), null, null, null, Number.FLOAT_NOT_SET, null, null, new Corners(5, 5, 5, 5)), new LayoutStyle(0x000300, null, null, null, null, 0.51, 1.1, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648), null, new EffectsStyle(32, new MoveEffect(180, -2147483648, null, false)));
		styleBlock68.setInheritedStyles(null, null, null, styleBlock65);
		hash66.set('slide', styleBlock68);
		var styleBlock69 = new StyleBlock(58, StyleBlockType.element, null, new LayoutStyle(0x000104, new RelativeLayout(-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0), null, null, null, 1, Number.FLOAT_NOT_SET, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648), new TextStyle(0x000247, 8, 'Lucida Grande', false, -1, null, null, Number.FLOAT_NOT_SET, TextAlign.CENTER, null, Number.FLOAT_NOT_SET, TextTransform.uppercase, null, -2147483648, -2147483648, -2147483648));
		styleBlock69.setInheritedStyles(null, styleBlock0, null, styleBlock65);
		var hash70 = new Hash();
		hash70.set('prime.gui.core.UITextField', styleBlock69);
		styleBlock65.setChildren(hash66, null, hash70);
		this.styleNameChildren.set('slideToggleButton', styleBlock65);
		this.idChildren.set('modal', new StyleBlock(88, StyleBlockType.id, new GraphicsStyle(2, new SolidFill(-2004318089)), new LayoutStyle(0x000300, null, null, null, null, 1, 1, -2147483648, -2147483648, -2147483648, -2147483648, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648, -2147483648)));
		this.idChildren.set('toolTip', new StyleBlock(104, StyleBlockType.id, new GraphicsStyle(2, new SolidFill(0x555555FF)), null, new TextStyle(7, 9, 'Verdana', false, -1, null, null, Number.FLOAT_NOT_SET, null, null, Number.FLOAT_NOT_SET, null, null, -2147483648, -2147483648, -2147483648)));
	}
}