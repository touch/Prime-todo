/*
 * Copyright (c) 2010, The PrimeVC Project Contributors
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
 * THIS SOFTWARE IS PROVIDED BY THE PRIMEVC PROJECT CONTRIBUTORS "AS IS" AND ANY
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
 import primevc.gui.styling.LayoutStyleFlags;
 import primevc.gui.styling.StyleChildren;
 import primevc.gui.styling.StyleBlockType;
 import primevc.gui.styling.StyleBlock;
 import primevc.types.Number;
 import primevc.core.geom.Box;
 import primevc.core.geom.Corners;
 import primevc.core.geom.space.Horizontal;
 import primevc.core.geom.space.Vertical;
 import primevc.gui.behaviours.layout.ClippedLayoutBehaviour;
 import primevc.gui.behaviours.scroll.ShowScrollbarsBehaviour;
 import primevc.gui.components.skins.BasicPanelSkin;
 import primevc.gui.components.skins.ButtonIconLabelSkin;
 import primevc.gui.components.skins.ButtonIconSkin;
 import primevc.gui.components.skins.ButtonLabelSkin;
 import primevc.gui.components.skins.InputFieldSkin;
 import primevc.gui.components.skins.SlidingToggleButtonSkin;
 import primevc.gui.effects.MoveEffect;
 import primevc.gui.graphics.borders.CapsStyle;
 import primevc.gui.graphics.borders.JointStyle;
 import primevc.gui.graphics.borders.SolidBorder;
 import primevc.gui.graphics.fills.SolidFill;
 import primevc.gui.graphics.shapes.RegularRectangle;
 import primevc.gui.layout.algorithms.float.HorizontalFloatAlgorithm;
 import primevc.gui.layout.algorithms.float.VerticalFloatAlgorithm;
 import primevc.gui.layout.algorithms.RelativeAlgorithm;
 import primevc.gui.layout.RelativeLayout;
 import primevc.gui.styling.EffectsStyle;
 import primevc.gui.styling.GraphicsStyle;
 import primevc.gui.styling.LayoutStyle;
 import primevc.gui.styling.StatesStyle;
 import primevc.gui.styling.StyleBlock;
 import primevc.gui.styling.StyleBlockType;
 import primevc.gui.styling.TextStyle;
 import primevc.gui.text.TextAlign;
 import primevc.gui.text.TextTransform;



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
		this.elementChildren.set('primevc.gui.display.IDisplayObject', styleBlock0);
		var styleBlock1 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(128, null, null, null, null, function (a) { return new ClippedLayoutBehaviour(a); }));
		styleBlock1.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('primevc.gui.core.UIWindow', styleBlock1);
		var styleBlock2 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(8, null, null, new RegularRectangle()));
		styleBlock2.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('primevc.gui.core.UIGraphic', styleBlock2);
		var styleBlock3 = new StyleBlock(0x00081A, StyleBlockType.element, null, new LayoutStyle(8, null, null, null, function () { return new VerticalFloatAlgorithm(Vertical.top, Horizontal.left); }));
		styleBlock3.setInheritedStyles(null, styleBlock0);
		var styleBlock4 = new StyleBlock(26, StyleBlockType.element, null, new LayoutStyle(0x000300, null, null, null, null, 1, 1));
		styleBlock4.setInheritedStyles(null, styleBlock0, null, styleBlock3);
		var hash5 = new Hash();
		hash5.set('primevc.gui.components.ListView', styleBlock4);
		var styleBlock6 = new StyleBlock(26, StyleBlockType.element, null, new LayoutStyle(0x000300, null, null, null, null, 1, 1));
		styleBlock6.setInheritedStyles(null, styleBlock4, null, styleBlock3);
		hash5.set('primevc.gui.components.SelectableListView', styleBlock6);
		styleBlock3.setChildren(null, null, hash5);
		this.elementChildren.set('primevc.gui.components.ListHolder', styleBlock3);
		var styleBlock7 = new StyleBlock(0x000C7A, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(0xAAAAAAFF), null, null, function () { return new ButtonLabelSkin(); }), new LayoutStyle(8, null, null, null, function () { return new HorizontalFloatAlgorithm(Horizontal.center, Vertical.center); }), new TextStyle(7, 10, 'Arial', false, 0xFFFFFFFF));
		styleBlock7.setInheritedStyles(null, styleBlock0);
		var styleBlock8 = new StyleBlock(26, StyleBlockType.element, null, new LayoutStyle(0x000100, null, null, null, null, LayoutStyleFlags.FILL));
		styleBlock8.setInheritedStyles(null, styleBlock0, null, styleBlock7);
		var hash9 = new Hash();
		hash9.set('primevc.gui.core.UITextField', styleBlock8);
		styleBlock7.setChildren(null, null, hash9);
		var styleBlock10 = new StyleBlock(104, StyleBlockType.elementState, new GraphicsStyle(2, new SolidFill(0xFFAAAAFF)), null, new TextStyle(4, Number.INT_NOT_SET, null, false, 0x000000FF));
		styleBlock10.setInheritedStyles(null, null, null, styleBlock7);
		var intHash11 = new IntHash();
		intHash11.set(2, styleBlock10);
		styleBlock7.states = new StatesStyle(2, intHash11);
		var styleBlock12 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(5, null, new SolidBorder(new SolidFill(0x000000FF), 1, false, CapsStyle.NONE, JointStyle.ROUND, false), null, function () { return new InputFieldSkin(); }));
		styleBlock12.setInheritedStyles(null, styleBlock7);
		this.elementChildren.set('primevc.gui.components.InputField', styleBlock12);
		var styleBlock13 = new StyleBlock(42, StyleBlockType.element, null, null, new TextStyle(3, 12, 'Verdana', false));
		styleBlock13.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('primevc.gui.components.Label', styleBlock13);
		var styleBlock14 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(8, null, null, new RegularRectangle()));
		styleBlock14.setInheritedStyles(null, styleBlock2);
		this.elementChildren.set('primevc.gui.components.Image', styleBlock14);
		this.elementChildren.set('primevc.gui.components.Button', styleBlock7);
		var styleBlock15 = new StyleBlock(90, StyleBlockType.element, new GraphicsStyle(129, null, null, null, null, function (a) { return new ShowScrollbarsBehaviour(a); }), new LayoutStyle(8));
		styleBlock15.setInheritedStyles(null, styleBlock12);
		this.elementChildren.set('primevc.gui.components.TextArea', styleBlock15);
		var styleBlock16 = new StyleBlock(90, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(0xFFFFFFFF)), new LayoutStyle(8, null, null, null, function () { return new RelativeAlgorithm(); }));
		styleBlock16.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('primevc.gui.components.SliderBase', styleBlock16);
		var styleBlock17 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(0x212121FF)));
		styleBlock17.setInheritedStyles(null, styleBlock16);
		this.elementChildren.set('primevc.gui.components.ScrollBar', styleBlock17);
		var styleBlock18 = new StyleBlock(90, StyleBlockType.element, new GraphicsStyle(1, null, null, null, function () { return new ButtonIconLabelSkin(); }), new LayoutStyle(32, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.FLOAT_NOT_SET, null, null, 40));
		styleBlock18.setInheritedStyles(null, styleBlock7);
		this.elementChildren.set('primevc.gui.components.ComboBox', styleBlock18);
		var styleBlock19 = new StyleBlock(0x00204A, StyleBlockType.element, new GraphicsStyle(1, null, null, null, function () { return new BasicPanelSkin(); }));
		styleBlock19.setInheritedStyles(null, styleBlock0);
		var styleBlock20 = new StyleBlock(72, StyleBlockType.id, new GraphicsStyle(1, null, null, null, function () { return new ButtonIconSkin(); }));
		styleBlock20.setInheritedStyles(null, null, null, styleBlock19);
		var hash21 = new Hash();
		hash21.set('closeBtn', styleBlock20);
		styleBlock19.setChildren(hash21);
		this.elementChildren.set('primevc.gui.components.Panel', styleBlock19);
		var styleBlock22 = new StyleBlock(0x00085A, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(0x111111FF)), new LayoutStyle(0x000108, null, null, null, function () { return new HorizontalFloatAlgorithm(Horizontal.center, Vertical.center); }, 1));
		styleBlock22.setInheritedStyles(null, styleBlock0);
		var styleBlock23 = new StyleBlock(0x00047E, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(0xCCCCCCFF), null, null, function () { return new ButtonLabelSkin(); }), new LayoutStyle(0x003000, null, new Box(4, 6, 4, 6), new Box(5, 5, 5, 5)), new TextStyle(5, 10, null, false, 0x333333FF));
		styleBlock23.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock22);
		var styleBlock24 = new StyleBlock(76, StyleBlockType.elementState, new GraphicsStyle(2, new SolidFill(0xFFFFFFFF)));
		styleBlock24.setInheritedStyles(null, null, styleBlock10, styleBlock23);
		var intHash25 = new IntHash();
		intHash25.set(2, styleBlock24);
		var styleBlock26 = new StyleBlock(72, StyleBlockType.elementState, new GraphicsStyle(2, new SolidFill(0xFFFFFFFF)));
		styleBlock26.setInheritedStyles(null, null, null, styleBlock23);
		intHash25.set(0x000800, styleBlock26);
		styleBlock23.states = new StatesStyle(0x000802, intHash25);
		var hash27 = new Hash();
		hash27.set('primevc.gui.components.Button', styleBlock23);
		styleBlock22.setChildren(null, null, hash27);
		this.elementChildren.set('primevc.gui.components.DebugBar', styleBlock22);
		var styleBlock28 = new StyleBlock(0x00205A, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(0xCCCCCCFF)), new LayoutStyle(0x000308, null, null, null, function () { return new VerticalFloatAlgorithm(Vertical.top, Horizontal.left); }, 1, 1));
		styleBlock28.setInheritedStyles(null, styleBlock1);
		var styleBlock29 = new StyleBlock(56, StyleBlockType.id, null, new LayoutStyle(0x000100, null, null, null, null, 1), new TextStyle(67, 50, 'Verdana', false, null, null, null, Number.FLOAT_NOT_SET, TextAlign.CENTER));
		styleBlock29.setInheritedStyles(null, null, null, styleBlock28);
		var hash30 = new Hash();
		hash30.set('title', styleBlock29);
		var styleBlock31 = new StyleBlock(0x000438, StyleBlockType.id, null, new LayoutStyle(0x000100, null, null, null, null, 0.8), new TextStyle(67, 40, 'Verdana', false, null, null, null, Number.FLOAT_NOT_SET, TextAlign.CENTER));
		styleBlock31.setInheritedStyles(null, null, null, styleBlock28);
		var styleBlock32 = new StyleBlock(56, StyleBlockType.idState, null, new LayoutStyle(0x000100, null, null, null, null, 0.8), new TextStyle(67, 40, 'Verdana', false, null, null, null, Number.FLOAT_NOT_SET, TextAlign.CENTER));
		styleBlock32.setInheritedStyles(null, null, null, styleBlock31);
		var intHash33 = new IntHash();
		intHash33.set(2, styleBlock32);
		styleBlock31.states = new StatesStyle(2, intHash33);
		hash30.set('input', styleBlock31);
		var styleBlock34 = new StyleBlock(88, StyleBlockType.id, new GraphicsStyle(2, new SolidFill(0xFFCCCCFF)), new LayoutStyle(0x000308, null, null, null, function () { return new VerticalFloatAlgorithm(Vertical.top, Horizontal.left); }, 1, 0.6));
		styleBlock34.setInheritedStyles(null, null, null, styleBlock28);
		hash30.set('listview', styleBlock34);
		styleBlock28.setChildren(hash30);
		this.elementChildren.set('com.ezeql.primevc.examples.todoapp.TodoGUI', styleBlock28);
		var styleBlock35 = new StyleBlock(26, StyleBlockType.element, null, new LayoutStyle(8, null, null, null, function () { return new HorizontalFloatAlgorithm(); }));
		styleBlock35.setInheritedStyles(null, styleBlock0);
		this.elementChildren.set('com.ezeql.primevc.examples.todoapp.ListRow', styleBlock35);
		var styleBlock36 = new StyleBlock(74, StyleBlockType.element, new GraphicsStyle(36, null, new SolidBorder(new SolidFill(0xFF00FFFF), 3, false, CapsStyle.NONE, JointStyle.ROUND, false), null, null, null, null, 0.7));
		var styleBlock37 = new StyleBlock(0x000808, StyleBlockType.styleName);
		styleBlock36.setInheritedStyles(null, styleBlock0, null, styleBlock37);
		var hash38 = new Hash();
		hash38.set('primevc.gui.core.UIComponent', styleBlock36);
		styleBlock37.setChildren(null, null, hash38);
		this.styleNameChildren.set('debug', styleBlock37);
		var styleBlock39 = new StyleBlock(30, StyleBlockType.element, null, new LayoutStyle(0x000300, null, null, null, null, 0, 1));
		var styleBlock40 = new StyleBlock(0x000818, StyleBlockType.styleName, null, new LayoutStyle(34, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, Number.INT_NOT_SET, 4, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.FLOAT_NOT_SET, null, null, 30));
		styleBlock39.setInheritedStyles(null, styleBlock0, styleBlock2, styleBlock40);
		var hash41 = new Hash();
		hash41.set('primevc.gui.core.UIGraphic', styleBlock39);
		var styleBlock42 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(0x666666FF)), new LayoutStyle(7, new RelativeLayout(Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, 0), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 6, 15));
		styleBlock42.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock40);
		hash41.set('primevc.gui.components.Button', styleBlock42);
		styleBlock40.setChildren(null, null, hash41);
		this.styleNameChildren.set('horizontalSlider', styleBlock40);
		var styleBlock43 = new StyleBlock(30, StyleBlockType.element, null, new LayoutStyle(0x000304, new RelativeLayout(Number.INT_NOT_SET, Number.INT_NOT_SET, 0), null, null, null, 1, 0));
		var styleBlock44 = new StyleBlock(0x000818, StyleBlockType.styleName, null, new LayoutStyle(129, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 4, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.FLOAT_NOT_SET, null, null, Number.INT_NOT_SET, Number.INT_NOT_SET, 30));
		styleBlock43.setInheritedStyles(null, styleBlock0, styleBlock2, styleBlock44);
		var hash45 = new Hash();
		hash45.set('primevc.gui.core.UIGraphic', styleBlock43);
		var styleBlock46 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(0x666666FF)), new LayoutStyle(135, new RelativeLayout(Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, 0), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 15, 6, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.FLOAT_NOT_SET, null, null, Number.INT_NOT_SET, Number.INT_NOT_SET, 15));
		styleBlock46.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock44);
		hash45.set('primevc.gui.components.Button', styleBlock46);
		styleBlock44.setChildren(null, null, hash45);
		this.styleNameChildren.set('verticalSlider', styleBlock44);
		var styleBlock47 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(2, new SolidFill(0x212121FF)), new LayoutStyle(39, new RelativeLayout(Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, 0), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 6, 9, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.FLOAT_NOT_SET, null, null, 15));
		var styleBlock48 = new StyleBlock(0x000818, StyleBlockType.styleName, null, new LayoutStyle(2, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, Number.INT_NOT_SET, 2));
		styleBlock47.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock48);
		var hash49 = new Hash();
		hash49.set('primevc.gui.components.Button', styleBlock47);
		styleBlock48.setChildren(null, null, hash49);
		this.styleNameChildren.set('horizontalScrollBar', styleBlock48);
		var styleBlock50 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(3, new SolidFill(0x212121FF)), new LayoutStyle(135, new RelativeLayout(Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, 0), null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 9, 6, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.FLOAT_NOT_SET, null, null, Number.INT_NOT_SET, Number.INT_NOT_SET, 15));
		var styleBlock51 = new StyleBlock(0x000818, StyleBlockType.styleName, null, new LayoutStyle(1, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 2));
		styleBlock50.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock51);
		var hash52 = new Hash();
		hash52.set('primevc.gui.components.Button', styleBlock50);
		styleBlock51.setChildren(null, null, hash52);
		this.styleNameChildren.set('verticalScrollBar', styleBlock51);
		var styleBlock53 = new StyleBlock(0x00085A, StyleBlockType.element, new GraphicsStyle(128, null, null, null, null, function (a) { return new ShowScrollbarsBehaviour(a); }), new LayoutStyle(0x00A3CB, null, new Box(0, 0, 0, 0), null, function () { return new VerticalFloatAlgorithm(Vertical.top, Horizontal.left); }, Number.EMPTY, Number.EMPTY, Number.EMPTY, Number.EMPTY, Number.INT_NOT_SET, 20, Number.FLOAT_NOT_SET, null, null, Number.INT_NOT_SET, Number.INT_NOT_SET, 60, 0x0001F4));
		var styleBlock54 = new StyleBlock(0x000848, StyleBlockType.styleName, new GraphicsStyle(0x000106, new SolidFill(0xF9F9F9FF), new SolidBorder(new SolidFill(0x707070FF), 1, false, CapsStyle.NONE, JointStyle.ROUND, false), null, null, null, null, Number.FLOAT_NOT_SET, null, null, new Corners(10, 10, 10, 10)));
		styleBlock53.setInheritedStyles(null, styleBlock0, null, styleBlock54);
		var styleBlock55 = new StyleBlock(94, StyleBlockType.element, new GraphicsStyle(1, null, null, null, function () { return new ButtonIconLabelSkin(); }), new LayoutStyle(0x011100, null, null, new Box(0, 0, 0, 0), null, 1, Number.FLOAT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.FLOAT_NOT_SET, null, null, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, 1));
		styleBlock55.setInheritedStyles(null, styleBlock0, styleBlock7, styleBlock53);
		var hash56 = new Hash();
		hash56.set('primevc.gui.components.Button', styleBlock55);
		styleBlock53.setChildren(null, null, hash56);
		var hash57 = new Hash();
		hash57.set('primevc.gui.components.SelectableListView', styleBlock53);
		styleBlock54.setChildren(null, null, hash57);
		this.styleNameChildren.set('comboList', styleBlock54);
		var styleBlock58 = new StyleBlock(88, StyleBlockType.id, new GraphicsStyle(2, new SolidFill(0xFF0000FF)), new LayoutStyle(4, new RelativeLayout(1, Number.INT_NOT_SET, 1)));
		var styleBlock59 = new StyleBlock(0x002858, StyleBlockType.styleName, new GraphicsStyle(0x000103, new SolidFill(0x666666FF), null, null, function () { return new SlidingToggleButtonSkin(); }, null, null, Number.FLOAT_NOT_SET, null, null, new Corners(5, 5, 5, 5)), new LayoutStyle(3, null, null, null, null, Number.FLOAT_NOT_SET, Number.FLOAT_NOT_SET, 50, 30));
		styleBlock58.setInheritedStyles(null, null, null, styleBlock59);
		var hash60 = new Hash();
		hash60.set('onBg', styleBlock58);
		var styleBlock61 = new StyleBlock(40, StyleBlockType.id, null, null, new TextStyle(4, Number.INT_NOT_SET, null, false, 0xFFFFFFFF));
		styleBlock61.setInheritedStyles(null, null, null, styleBlock59);
		hash60.set('onLabel', styleBlock61);
		var styleBlock62 = new StyleBlock(216, StyleBlockType.id, new GraphicsStyle(0x00010A, new SolidFill(0xFFFFFFFF), null, new RegularRectangle(), null, null, null, Number.FLOAT_NOT_SET, null, null, new Corners(5, 5, 5, 5)), new LayoutStyle(0x000300, null, null, null, null, 0.51, 1.1), null, new EffectsStyle(32, new MoveEffect(180)));
		styleBlock62.setInheritedStyles(null, null, null, styleBlock59);
		hash60.set('slide', styleBlock62);
		var styleBlock63 = new StyleBlock(58, StyleBlockType.element, null, new LayoutStyle(0x000104, new RelativeLayout(Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, Number.INT_NOT_SET, 0), null, null, null, 1), new TextStyle(0x000247, 8, 'Lucida Grande', false, 0xFFFFFFFF, null, null, Number.FLOAT_NOT_SET, TextAlign.CENTER, null, Number.FLOAT_NOT_SET, TextTransform.uppercase));
		styleBlock63.setInheritedStyles(null, styleBlock0, null, styleBlock59);
		var hash64 = new Hash();
		hash64.set('primevc.gui.core.UITextField', styleBlock63);
		styleBlock59.setChildren(hash60, null, hash64);
		this.styleNameChildren.set('slideToggleButton', styleBlock59);
		this.idChildren.set('modal', new StyleBlock(88, StyleBlockType.id, new GraphicsStyle(2, new SolidFill(0x88888877)), new LayoutStyle(0x000300, null, null, null, null, 1, 1)));
		this.idChildren.set('toolTip', new StyleBlock(104, StyleBlockType.id, new GraphicsStyle(2, new SolidFill(0x555555FF)), null, new TextStyle(7, 9, 'Verdana', false, 0xFFFFFFFF)));
	}
}