<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
<drawing>
<settings>
<setting alwaysvectorfont="yes"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="1" fill="3" visible="no" active="no"/>
<layer number="3" name="Route3" color="4" fill="3" visible="no" active="no"/>
<layer number="4" name="Route4" color="1" fill="4" visible="no" active="no"/>
<layer number="5" name="Route5" color="4" fill="4" visible="no" active="no"/>
<layer number="6" name="Route6" color="1" fill="8" visible="no" active="no"/>
<layer number="7" name="Route7" color="4" fill="8" visible="no" active="no"/>
<layer number="8" name="Route8" color="1" fill="2" visible="no" active="no"/>
<layer number="9" name="Route9" color="4" fill="2" visible="no" active="no"/>
<layer number="10" name="Route10" color="1" fill="7" visible="no" active="no"/>
<layer number="11" name="Route11" color="4" fill="7" visible="no" active="no"/>
<layer number="12" name="Route12" color="1" fill="5" visible="no" active="no"/>
<layer number="13" name="Route13" color="4" fill="5" visible="no" active="no"/>
<layer number="14" name="Route14" color="1" fill="6" visible="no" active="no"/>
<layer number="15" name="Route15" color="4" fill="6" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="frames" urn="urn:adsk.eagle:library:229">
<description>&lt;b&gt;Frames for Sheet and Layout&lt;/b&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="A4L-LOC" urn="urn:adsk.eagle:symbol:13874/1" library_version="1">
<wire x1="256.54" y1="3.81" x2="256.54" y2="8.89" width="0.1016" layer="94"/>
<wire x1="256.54" y1="8.89" x2="256.54" y2="13.97" width="0.1016" layer="94"/>
<wire x1="256.54" y1="13.97" x2="256.54" y2="19.05" width="0.1016" layer="94"/>
<wire x1="256.54" y1="19.05" x2="256.54" y2="24.13" width="0.1016" layer="94"/>
<wire x1="161.29" y1="3.81" x2="161.29" y2="24.13" width="0.1016" layer="94"/>
<wire x1="161.29" y1="24.13" x2="215.265" y2="24.13" width="0.1016" layer="94"/>
<wire x1="215.265" y1="24.13" x2="256.54" y2="24.13" width="0.1016" layer="94"/>
<wire x1="246.38" y1="3.81" x2="246.38" y2="8.89" width="0.1016" layer="94"/>
<wire x1="246.38" y1="8.89" x2="256.54" y2="8.89" width="0.1016" layer="94"/>
<wire x1="246.38" y1="8.89" x2="215.265" y2="8.89" width="0.1016" layer="94"/>
<wire x1="215.265" y1="8.89" x2="215.265" y2="3.81" width="0.1016" layer="94"/>
<wire x1="215.265" y1="8.89" x2="215.265" y2="13.97" width="0.1016" layer="94"/>
<wire x1="215.265" y1="13.97" x2="256.54" y2="13.97" width="0.1016" layer="94"/>
<wire x1="215.265" y1="13.97" x2="215.265" y2="19.05" width="0.1016" layer="94"/>
<wire x1="215.265" y1="19.05" x2="256.54" y2="19.05" width="0.1016" layer="94"/>
<wire x1="215.265" y1="19.05" x2="215.265" y2="24.13" width="0.1016" layer="94"/>
<text x="217.17" y="15.24" size="2.54" layer="94">&gt;DRAWING_NAME</text>
<text x="217.17" y="10.16" size="2.286" layer="94">&gt;LAST_DATE_TIME</text>
<text x="230.505" y="5.08" size="2.54" layer="94">&gt;SHEET</text>
<text x="216.916" y="4.953" size="2.54" layer="94">Sheet:</text>
<frame x1="0" y1="0" x2="260.35" y2="179.07" columns="6" rows="4" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="A4L-LOC" urn="urn:adsk.eagle:component:13926/1" prefix="FRAME" uservalue="yes" library_version="1">
<description>&lt;b&gt;FRAME&lt;/b&gt;&lt;p&gt;
DIN A4, landscape with location and doc. field</description>
<gates>
<gate name="G$1" symbol="A4L-LOC" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="con-molex" urn="urn:adsk.eagle:library:165">
<description>&lt;b&gt;Molex Connectors&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="KK-156-4" urn="urn:adsk.eagle:footprint:8078404/1" library_version="5">
<description>&lt;b&gt;KK® 396 Header, Vertical, Friction Lock, 4 Circuits, Tin (Sn) Plating&lt;/b&gt;&lt;p&gt;&lt;a href =http://www.molex.com/pdm_docs/sd/026604040_sd.pdf&gt;Datasheet &lt;/a&gt;</description>
<wire x1="7.77" y1="4.95" x2="5.97" y2="4.95" width="0.2032" layer="21"/>
<wire x1="5.97" y1="4.95" x2="-5.945" y2="4.95" width="0.2032" layer="21"/>
<wire x1="-5.945" y1="4.95" x2="-7.745" y2="4.95" width="0.2032" layer="21"/>
<wire x1="-7.745" y1="4.95" x2="-7.745" y2="-4.825" width="0.2032" layer="21"/>
<wire x1="-7.745" y1="-4.825" x2="7.77" y2="-4.825" width="0.2032" layer="21"/>
<wire x1="7.77" y1="-4.825" x2="7.77" y2="4.95" width="0.2032" layer="21"/>
<wire x1="-5.945" y1="2.525" x2="5.97" y2="2.525" width="0.2032" layer="21"/>
<wire x1="5.97" y1="2.525" x2="5.97" y2="4.95" width="0.2032" layer="21"/>
<wire x1="-5.945" y1="2.525" x2="-5.945" y2="4.95" width="0.2032" layer="21"/>
<pad name="1" x="-5.94" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="2" x="-1.98" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="3" x="1.98" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="4" x="5.94" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<text x="-8.44" y="-4.445" size="1.27" layer="25" rot="R90">&gt;NAME</text>
<text x="9.71" y="-4.445" size="1.27" layer="27" rot="R90">&gt;VALUE</text>
</package>
</packages>
<packages3d>
<package3d name="KK-156-4" urn="urn:adsk.eagle:package:8078802/1" type="box" library_version="5">
<description>&lt;b&gt;KK® 396 Header, Vertical, Friction Lock, 4 Circuits, Tin (Sn) Plating&lt;/b&gt;&lt;p&gt;&lt;a href =http://www.molex.com/pdm_docs/sd/026604040_sd.pdf&gt;Datasheet &lt;/a&gt;</description>
<packageinstances>
<packageinstance name="KK-156-4"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="MV" urn="urn:adsk.eagle:symbol:6783/2" library_version="5">
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.6096" layer="94"/>
<text x="2.54" y="-0.762" size="1.524" layer="95">&gt;NAME</text>
<text x="-0.762" y="1.397" size="1.778" layer="96">&gt;VALUE</text>
<pin name="S" x="-2.54" y="0" visible="off" length="short" direction="pas"/>
</symbol>
<symbol name="M" urn="urn:adsk.eagle:symbol:6785/2" library_version="5">
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.6096" layer="94"/>
<text x="2.54" y="-0.762" size="1.524" layer="95">&gt;NAME</text>
<pin name="S" x="-2.54" y="0" visible="off" length="short" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="KK-156-4" urn="urn:adsk.eagle:component:8079130/3" prefix="X" uservalue="yes" library_version="5">
<description>&lt;b&gt;KK 156 HEADER&lt;/b&gt;&lt;p&gt;
Source: http://www.molex.com/pdm_docs/sd/026604100_sd.pdf</description>
<gates>
<gate name="-1" symbol="MV" x="0" y="0" addlevel="always" swaplevel="1"/>
<gate name="-2" symbol="M" x="0" y="-2.54" addlevel="always" swaplevel="1"/>
<gate name="-3" symbol="M" x="0" y="-5.08" addlevel="always" swaplevel="1"/>
<gate name="-4" symbol="M" x="0" y="-7.62" addlevel="always" swaplevel="1"/>
</gates>
<devices>
<device name="" package="KK-156-4">
<connects>
<connect gate="-1" pin="S" pad="1"/>
<connect gate="-2" pin="S" pad="2"/>
<connect gate="-3" pin="S" pad="3"/>
<connect gate="-4" pin="S" pad="4"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:8078802/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="MF" value="MOLEX" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
<attribute name="POPULARITY" value="0" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="supply1" urn="urn:adsk.eagle:library:371">
<description>&lt;b&gt;Supply Symbols&lt;/b&gt;&lt;p&gt;
 GND, VCC, 0V, +5V, -5V, etc.&lt;p&gt;
 Please keep in mind, that these devices are necessary for the
 automatic wiring of the supply signals.&lt;p&gt;
 The pin name defined in the symbol is identical to the net which is to be wired automatically.&lt;p&gt;
 In this library the device names are the same as the pin names of the symbols, therefore the correct signal names appear next to the supply symbols in the schematic.&lt;p&gt;
 &lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="GND" urn="urn:adsk.eagle:symbol:26925/1" library_version="1">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GND" urn="urn:adsk.eagle:component:26954/1" prefix="GND" library_version="1">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="con-molex_KK-156-Horizontal">
<description>&lt;b&gt;Molex Connectors&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="KK-156-15_F">
<description>&lt;b&gt;KK® 396 Header, Vertical, Friction Lock, 15 Circuits, Tin (Sn) Plating&lt;/b&gt;&lt;p&gt;&lt;a href =http://www.molex.com/pdm_docs/sd/026604150_sd.pdf&gt;Datasheet &lt;/a&gt;</description>
<wire x1="-29.5" y1="-7.9" x2="29.55" y2="-7.9" width="0.2032" layer="21"/>
<pad name="1" x="-27.72" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="2" x="-23.76" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="3" x="-19.8" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="4" x="-15.84" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="5" x="-11.88" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="6" x="-7.92" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="7" x="-3.96" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="8" x="0" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="9" x="3.96" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="10" x="7.92" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="11" x="11.88" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="12" x="15.84" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="13" x="19.8" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="14" x="23.76" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="15" x="27.72" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<text x="-30.22" y="-4.445" size="1.27" layer="25" rot="R90">&gt;NAME</text>
<text x="31.49" y="-4.445" size="1.27" layer="27" rot="R90">&gt;VALUE</text>
<wire x1="-29.5" y1="-9.81" x2="29.55" y2="-9.81" width="0.2032" layer="51"/>
<wire x1="-29.5" y1="-5.41" x2="-29.5" y2="-9.81" width="0.2032" layer="51"/>
<wire x1="29.55" y1="-5.41" x2="29.55" y2="-9.81" width="0.2032" layer="51"/>
<wire x1="-29.5" y1="1.6" x2="-29.5" y2="-7.9" width="0.2032" layer="21"/>
<wire x1="29.55" y1="1.6" x2="29.55" y2="-7.9" width="0.2032" layer="21"/>
<wire x1="-29.5" y1="1.6" x2="-28.81" y2="1.6" width="0.2032" layer="21"/>
<wire x1="-26.63" y1="1.6" x2="-24.85" y2="1.6" width="0.2032" layer="21"/>
<wire x1="-22.67" y1="1.6" x2="-20.89" y2="1.6" width="0.2032" layer="21"/>
<wire x1="-18.71" y1="1.6" x2="-16.93" y2="1.6" width="0.2032" layer="21"/>
<wire x1="-14.75" y1="1.6" x2="-12.97" y2="1.6" width="0.2032" layer="21"/>
<wire x1="-10.8" y1="1.6" x2="-9.01" y2="1.6" width="0.2032" layer="21"/>
<wire x1="-6.83" y1="1.6" x2="-5.05" y2="1.6" width="0.2032" layer="21"/>
<wire x1="-2.87" y1="1.6" x2="-1.09" y2="1.6" width="0.2032" layer="21"/>
<wire x1="1.09" y1="1.6" x2="2.87" y2="1.6" width="0.2032" layer="21"/>
<wire x1="5.05" y1="1.6" x2="6.83" y2="1.6" width="0.2032" layer="21"/>
<wire x1="9.01" y1="1.6" x2="10.79" y2="1.6" width="0.2032" layer="21"/>
<wire x1="12.97" y1="1.6" x2="14.75" y2="1.6" width="0.2032" layer="21"/>
<wire x1="16.93" y1="1.6" x2="18.71" y2="1.6" width="0.2032" layer="21"/>
<wire x1="20.89" y1="1.6" x2="22.67" y2="1.6" width="0.2032" layer="21"/>
<wire x1="24.85" y1="1.6" x2="26.63" y2="1.6" width="0.2032" layer="21"/>
<wire x1="28.81" y1="1.6" x2="29.55" y2="1.6" width="0.2032" layer="21"/>
</package>
<package name="KK-156-15" urn="urn:adsk.eagle:footprint:8078414/1" locally_modified="yes">
<description>&lt;b&gt;KK® 396 Header, Vertical, Friction Lock, 15 Circuits, Tin (Sn) Plating&lt;/b&gt;&lt;p&gt;&lt;a href =http://www.molex.com/pdm_docs/sd/026604150_sd.pdf&gt;Datasheet &lt;/a&gt;</description>
<wire x1="-29.5" y1="-5.41" x2="29.55" y2="-5.41" width="0.2032" layer="21"/>
<pad name="1" x="-27.72" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="2" x="-23.76" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="3" x="-19.8" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="4" x="-15.84" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="5" x="-11.88" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="6" x="-7.92" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="7" x="-3.96" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="8" x="0" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="9" x="3.96" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="10" x="7.92" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="11" x="11.88" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="12" x="15.84" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="13" x="19.8" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="14" x="23.76" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<pad name="15" x="27.72" y="0" drill="1.7" diameter="2.1844" shape="long" rot="R90"/>
<text x="-30.22" y="-4.445" size="1.27" layer="25" rot="R90">&gt;NAME</text>
<text x="31.49" y="-4.445" size="1.27" layer="27" rot="R90">&gt;VALUE</text>
<wire x1="-29.5" y1="-8.71" x2="29.55" y2="-8.71" width="0.2032" layer="21"/>
<wire x1="-29.5" y1="-5.41" x2="-29.5" y2="-8.71" width="0.2032" layer="21"/>
<wire x1="29.55" y1="-5.41" x2="29.55" y2="-8.71" width="0.2032" layer="21"/>
</package>
</packages>
<packages3d>
<package3d name="KK-156-15" urn="urn:adsk.eagle:package:8078824/1" type="box">
<description>&lt;b&gt;KK® 396 Header, Vertical, Friction Lock, 15 Circuits, Tin (Sn) Plating&lt;/b&gt;&lt;p&gt;&lt;a href =http://www.molex.com/pdm_docs/sd/026604150_sd.pdf&gt;Datasheet &lt;/a&gt;</description>
<packageinstances>
<packageinstance name="KK-156-15"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="MV" urn="urn:adsk.eagle:symbol:6783/2" locally_modified="yes">
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.6096" layer="94"/>
<text x="2.54" y="-0.762" size="1.524" layer="95">&gt;NAME</text>
<text x="-0.762" y="1.397" size="1.778" layer="96">&gt;VALUE</text>
<pin name="S" x="-2.54" y="0" visible="off" length="short" direction="pas"/>
</symbol>
<symbol name="M" urn="urn:adsk.eagle:symbol:6785/2">
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.6096" layer="94"/>
<text x="2.54" y="-0.762" size="1.524" layer="95">&gt;NAME</text>
<pin name="S" x="-2.54" y="0" visible="off" length="short" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="KK-156-15_F" prefix="X" uservalue="yes">
<description>&lt;b&gt;KK 156 HEADER&lt;/b&gt;&lt;p&gt;
Source: http://www.molex.com/pdm_docs/sd/026604100_sd.pdf</description>
<gates>
<gate name="-1" symbol="MV" x="0" y="0" addlevel="always" swaplevel="1"/>
<gate name="-2" symbol="M" x="0" y="-2.54" addlevel="always" swaplevel="1"/>
<gate name="-3" symbol="M" x="0" y="-5.08" addlevel="always" swaplevel="1"/>
<gate name="-4" symbol="M" x="0" y="-7.62" addlevel="always" swaplevel="1"/>
<gate name="-5" symbol="M" x="0" y="-10.16" addlevel="always" swaplevel="1"/>
<gate name="-6" symbol="M" x="0" y="-12.7" addlevel="always" swaplevel="1"/>
<gate name="-7" symbol="M" x="0" y="-15.24" addlevel="always" swaplevel="1"/>
<gate name="-8" symbol="M" x="0" y="-17.78" addlevel="always" swaplevel="1"/>
<gate name="-9" symbol="M" x="0" y="-20.32" addlevel="always" swaplevel="1"/>
<gate name="-10" symbol="M" x="0" y="-22.86" addlevel="always" swaplevel="1"/>
<gate name="-11" symbol="M" x="0" y="-25.4" addlevel="always" swaplevel="1"/>
<gate name="-12" symbol="M" x="0" y="-27.94" addlevel="always" swaplevel="1"/>
<gate name="-13" symbol="M" x="0" y="-30.48" addlevel="always" swaplevel="1"/>
<gate name="-14" symbol="M" x="0" y="-33.02" addlevel="always" swaplevel="1"/>
<gate name="-15" symbol="M" x="0" y="-35.56" addlevel="always" swaplevel="1"/>
</gates>
<devices>
<device name="KK-156-15-F" package="KK-156-15_F">
<connects>
<connect gate="-1" pin="S" pad="1"/>
<connect gate="-10" pin="S" pad="10"/>
<connect gate="-11" pin="S" pad="11"/>
<connect gate="-12" pin="S" pad="12"/>
<connect gate="-13" pin="S" pad="13"/>
<connect gate="-14" pin="S" pad="14"/>
<connect gate="-15" pin="S" pad="15"/>
<connect gate="-2" pin="S" pad="2"/>
<connect gate="-3" pin="S" pad="3"/>
<connect gate="-4" pin="S" pad="4"/>
<connect gate="-5" pin="S" pad="5"/>
<connect gate="-6" pin="S" pad="6"/>
<connect gate="-7" pin="S" pad="7"/>
<connect gate="-8" pin="S" pad="8"/>
<connect gate="-9" pin="S" pad="9"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="KK-156-15" urn="urn:adsk.eagle:component:8079144/3" prefix="X" uservalue="yes">
<description>&lt;b&gt;KK 156 HEADER&lt;/b&gt;&lt;p&gt;
Source: http://www.molex.com/pdm_docs/sd/026604100_sd.pdf</description>
<gates>
<gate name="-1" symbol="MV" x="0" y="0" addlevel="always" swaplevel="1"/>
<gate name="-2" symbol="M" x="0" y="-2.54" addlevel="always" swaplevel="1"/>
<gate name="-3" symbol="M" x="0" y="-5.08" addlevel="always" swaplevel="1"/>
<gate name="-4" symbol="M" x="0" y="-7.62" addlevel="always" swaplevel="1"/>
<gate name="-5" symbol="M" x="0" y="-10.16" addlevel="always" swaplevel="1"/>
<gate name="-6" symbol="M" x="0" y="-12.7" addlevel="always" swaplevel="1"/>
<gate name="-7" symbol="M" x="0" y="-15.24" addlevel="always" swaplevel="1"/>
<gate name="-8" symbol="M" x="0" y="-17.78" addlevel="always" swaplevel="1"/>
<gate name="-9" symbol="M" x="0" y="-20.32" addlevel="always" swaplevel="1"/>
<gate name="-10" symbol="M" x="0" y="-22.86" addlevel="always" swaplevel="1"/>
<gate name="-11" symbol="M" x="0" y="-25.4" addlevel="always" swaplevel="1"/>
<gate name="-12" symbol="M" x="0" y="-27.94" addlevel="always" swaplevel="1"/>
<gate name="-13" symbol="M" x="0" y="-30.48" addlevel="always" swaplevel="1"/>
<gate name="-14" symbol="M" x="0" y="-33.02" addlevel="always" swaplevel="1"/>
<gate name="-15" symbol="M" x="0" y="-35.56" addlevel="always" swaplevel="1"/>
</gates>
<devices>
<device name="" package="KK-156-15">
<connects>
<connect gate="-1" pin="S" pad="1"/>
<connect gate="-10" pin="S" pad="10"/>
<connect gate="-11" pin="S" pad="11"/>
<connect gate="-12" pin="S" pad="12"/>
<connect gate="-13" pin="S" pad="13"/>
<connect gate="-14" pin="S" pad="14"/>
<connect gate="-15" pin="S" pad="15"/>
<connect gate="-2" pin="S" pad="2"/>
<connect gate="-3" pin="S" pad="3"/>
<connect gate="-4" pin="S" pad="4"/>
<connect gate="-5" pin="S" pad="5"/>
<connect gate="-6" pin="S" pad="6"/>
<connect gate="-7" pin="S" pad="7"/>
<connect gate="-8" pin="S" pad="8"/>
<connect gate="-9" pin="S" pad="9"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:8078824/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="MF" value="MOLEX" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
<attribute name="POPULARITY" value="0" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="FRAME1" library="frames" library_urn="urn:adsk.eagle:library:229" deviceset="A4L-LOC" device=""/>
<part name="X3" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="KK-156-4" device="" package3d_urn="urn:adsk.eagle:package:8078802/1" override_package3d_urn="urn:adsk.eagle:package:16129121/2" override_package_urn="urn:adsk.eagle:footprint:8078404/1"/>
<part name="X1" library="con-molex_KK-156-Horizontal" deviceset="KK-156-15_F" device="KK-156-15-F" override_package3d_urn="urn:adsk.eagle:package:16129078/2" override_package_urn="urn:adsk.eagle:footprint:16129079/1" override_locally_modified="yes"/>
<part name="GND1" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X2" library="con-molex_KK-156-Horizontal" deviceset="KK-156-15" device="" package3d_urn="urn:adsk.eagle:package:8078824/1" override_package3d_urn="urn:adsk.eagle:package:16129117/3" override_package_urn="urn:adsk.eagle:footprint:16129118/1"/>
</parts>
<sheets>
<sheet>
<plain>
<text x="22.352" y="144.018" size="1.778" layer="95">12V</text>
<text x="22.352" y="136.144" size="1.778" layer="95">12V</text>
<text x="22.352" y="128.524" size="1.778" layer="95">5V</text>
<text x="22.098" y="148.844" size="1.778" layer="95">GND</text>
<text x="20.574" y="146.558" size="1.778" layer="95">-12V</text>
<text x="22.606" y="141.478" size="1.778" layer="95">N.C.</text>
<text x="22.606" y="138.684" size="1.778" layer="95">KEY</text>
<text x="22.86" y="154.94" size="1.778" layer="95">DE</text>
<text x="7.62" y="154.94" size="1.778" layer="95">Whitestar</text>
<text x="13.716" y="115.824" size="1.778" layer="95">KEY</text>
<text x="21.336" y="113.538" size="1.778" layer="95">GND</text>
<text x="21.336" y="116.078" size="1.778" layer="95">GND</text>
<text x="21.336" y="118.618" size="1.778" layer="95">GND</text>
<text x="21.336" y="121.158" size="1.778" layer="95">GND</text>
<text x="21.336" y="123.698" size="1.778" layer="95">GND</text>
<text x="13.716" y="113.538" size="1.778" layer="95">GND</text>
<text x="13.716" y="118.618" size="1.778" layer="95">GND</text>
<text x="13.716" y="121.158" size="1.778" layer="95">GND</text>
<text x="13.716" y="123.698" size="1.778" layer="95">GND</text>
<text x="13.716" y="126.238" size="1.778" layer="95">GND</text>
<text x="13.716" y="128.778" size="1.778" layer="95">GND</text>
<text x="13.716" y="131.064" size="1.778" layer="95">5V</text>
<text x="13.716" y="133.604" size="1.778" layer="95">5V</text>
<text x="13.716" y="136.144" size="1.778" layer="95">5V</text>
<text x="13.716" y="138.684" size="1.778" layer="95">5V</text>
<text x="13.716" y="141.224" size="1.778" layer="95">5V</text>
<text x="22.352" y="125.984" size="1.778" layer="95">5V</text>
<text x="22.352" y="131.064" size="1.778" layer="95">5V</text>
<text x="22.352" y="133.604" size="1.778" layer="95">5V</text>
<text x="13.716" y="144.018" size="1.778" layer="95">12V</text>
<text x="13.716" y="146.558" size="1.778" layer="95">12V</text>
<text x="12.954" y="149.098" size="1.778" layer="95">-12V</text>
</plain>
<instances>
<instance part="FRAME1" gate="G$1" x="0" y="0" smashed="yes">
<attribute name="DRAWING_NAME" x="217.17" y="15.24" size="2.54" layer="94"/>
<attribute name="LAST_DATE_TIME" x="217.17" y="10.16" size="2.286" layer="94"/>
<attribute name="SHEET" x="230.505" y="5.08" size="2.54" layer="94"/>
</instance>
<instance part="X3" gate="-1" x="63.5" y="83.82" smashed="yes">
<attribute name="NAME" x="66.04" y="83.058" size="1.524" layer="95"/>
<attribute name="VALUE" x="62.738" y="85.217" size="1.778" layer="96"/>
</instance>
<instance part="X3" gate="-2" x="63.5" y="81.28" smashed="yes">
<attribute name="NAME" x="66.04" y="80.518" size="1.524" layer="95"/>
</instance>
<instance part="X3" gate="-3" x="63.5" y="78.74" smashed="yes">
<attribute name="NAME" x="66.04" y="77.978" size="1.524" layer="95"/>
</instance>
<instance part="X3" gate="-4" x="63.5" y="76.2" smashed="yes">
<attribute name="NAME" x="66.04" y="75.438" size="1.524" layer="95"/>
</instance>
<instance part="X1" gate="-1" x="35.56" y="149.86" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="149.098" size="1.524" layer="95" rot="MR0"/>
<attribute name="VALUE" x="36.322" y="151.257" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X1" gate="-2" x="35.56" y="147.32" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="146.558" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-3" x="35.56" y="144.78" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="144.018" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-4" x="35.56" y="142.24" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="141.478" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-5" x="35.56" y="139.7" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="138.938" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-6" x="35.56" y="137.16" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="136.398" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-7" x="35.56" y="134.62" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="133.858" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-8" x="35.56" y="132.08" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="131.318" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-9" x="35.56" y="129.54" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="128.778" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-10" x="35.56" y="127" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="126.238" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-11" x="35.56" y="124.46" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="123.698" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-12" x="35.56" y="121.92" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="121.158" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-13" x="35.56" y="119.38" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="118.618" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-14" x="35.56" y="116.84" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="116.078" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="X1" gate="-15" x="35.56" y="114.3" smashed="yes" rot="MR0">
<attribute name="NAME" x="33.02" y="113.538" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="GND1" gate="1" x="48.26" y="76.2" smashed="yes">
<attribute name="VALUE" x="45.72" y="73.66" size="1.778" layer="96"/>
</instance>
<instance part="X2" gate="-1" x="93.98" y="114.3" smashed="yes">
<attribute name="NAME" x="96.52" y="113.538" size="1.524" layer="95"/>
<attribute name="VALUE" x="93.218" y="115.697" size="1.778" layer="96"/>
</instance>
<instance part="X2" gate="-2" x="93.98" y="116.84" smashed="yes">
<attribute name="NAME" x="96.52" y="116.078" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-3" x="93.98" y="119.38" smashed="yes">
<attribute name="NAME" x="96.52" y="118.618" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-4" x="93.98" y="121.92" smashed="yes">
<attribute name="NAME" x="96.52" y="121.158" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-5" x="93.98" y="124.46" smashed="yes">
<attribute name="NAME" x="96.52" y="123.698" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-6" x="93.98" y="127" smashed="yes">
<attribute name="NAME" x="96.52" y="126.238" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-7" x="93.98" y="129.54" smashed="yes">
<attribute name="NAME" x="96.52" y="128.778" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-8" x="93.98" y="132.08" smashed="yes">
<attribute name="NAME" x="96.52" y="131.318" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-9" x="93.98" y="134.62" smashed="yes">
<attribute name="NAME" x="96.52" y="133.858" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-10" x="93.98" y="137.16" smashed="yes">
<attribute name="NAME" x="96.52" y="136.398" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-11" x="93.98" y="139.7" smashed="yes">
<attribute name="NAME" x="96.52" y="138.938" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-12" x="93.98" y="142.24" smashed="yes">
<attribute name="NAME" x="96.52" y="141.478" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-13" x="93.98" y="144.78" smashed="yes">
<attribute name="NAME" x="96.52" y="144.018" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-14" x="93.98" y="147.32" smashed="yes">
<attribute name="NAME" x="96.52" y="146.558" size="1.524" layer="95"/>
</instance>
<instance part="X2" gate="-15" x="93.98" y="149.86" smashed="yes">
<attribute name="NAME" x="96.52" y="149.098" size="1.524" layer="95"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="12V" class="0">
<segment>
<wire x1="38.1" y1="144.78" x2="55.88" y2="144.78" width="0.1524" layer="91"/>
<label x="58.42" y="144.78" size="1.4224" layer="95"/>
<pinref part="X1" gate="-3" pin="S"/>
<pinref part="X2" gate="-13" pin="S"/>
<pinref part="X3" gate="-3" pin="S"/>
<wire x1="55.88" y1="144.78" x2="91.44" y2="144.78" width="0.1524" layer="91"/>
<wire x1="60.96" y1="78.74" x2="55.88" y2="78.74" width="0.1524" layer="91"/>
<wire x1="55.88" y1="144.78" x2="55.88" y2="78.74" width="0.1524" layer="91"/>
<junction x="55.88" y="144.78"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<wire x1="91.44" y1="147.32" x2="38.1" y2="147.32" width="0.1524" layer="91"/>
<pinref part="X1" gate="-2" pin="S"/>
<pinref part="X2" gate="-14" pin="S"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<wire x1="91.44" y1="142.24" x2="38.1" y2="142.24" width="0.1524" layer="91"/>
<pinref part="X1" gate="-4" pin="S"/>
<pinref part="X2" gate="-12" pin="S"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<wire x1="38.1" y1="139.7" x2="91.44" y2="139.7" width="0.1524" layer="91"/>
<pinref part="X1" gate="-5" pin="S"/>
<pinref part="X2" gate="-11" pin="S"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<wire x1="91.44" y1="129.54" x2="38.1" y2="129.54" width="0.1524" layer="91"/>
<pinref part="X1" gate="-9" pin="S"/>
<pinref part="X2" gate="-7" pin="S"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="X1" gate="-10" pin="S"/>
<wire x1="38.1" y1="127" x2="91.44" y2="127" width="0.1524" layer="91"/>
<pinref part="X2" gate="-6" pin="S"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<wire x1="48.26" y1="81.28" x2="48.26" y2="78.74" width="0.1524" layer="91"/>
<pinref part="GND1" gate="1" pin="GND"/>
<pinref part="X3" gate="-2" pin="S"/>
<wire x1="48.26" y1="81.28" x2="60.96" y2="81.28" width="0.1524" layer="91"/>
<wire x1="40.64" y1="81.28" x2="48.26" y2="81.28" width="0.1524" layer="91"/>
<wire x1="40.64" y1="114.3" x2="91.44" y2="114.3" width="0.1524" layer="91"/>
<wire x1="38.1" y1="114.3" x2="40.64" y2="114.3" width="0.1524" layer="91"/>
<pinref part="X1" gate="-15" pin="S"/>
<wire x1="40.64" y1="114.3" x2="40.64" y2="81.28" width="0.1524" layer="91"/>
<junction x="40.64" y="114.3"/>
<junction x="48.26" y="81.28"/>
<pinref part="X2" gate="-1" pin="S"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="X2" gate="-15" pin="S"/>
<wire x1="38.1" y1="149.86" x2="91.44" y2="149.86" width="0.1524" layer="91"/>
<pinref part="X1" gate="-1" pin="S"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<wire x1="38.1" y1="137.16" x2="91.44" y2="137.16" width="0.1524" layer="91"/>
<pinref part="X1" gate="-6" pin="S"/>
<pinref part="X2" gate="-10" pin="S"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<wire x1="38.1" y1="132.08" x2="58.42" y2="132.08" width="0.1524" layer="91"/>
<pinref part="X1" gate="-8" pin="S"/>
<pinref part="X2" gate="-8" pin="S"/>
<pinref part="X3" gate="-1" pin="S"/>
<wire x1="58.42" y1="132.08" x2="91.44" y2="132.08" width="0.1524" layer="91"/>
<wire x1="58.42" y1="83.82" x2="60.96" y2="83.82" width="0.1524" layer="91"/>
<wire x1="58.42" y1="132.08" x2="58.42" y2="83.82" width="0.1524" layer="91"/>
<junction x="58.42" y="132.08"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="X1" gate="-7" pin="S"/>
<pinref part="X2" gate="-9" pin="S"/>
<wire x1="91.44" y1="134.62" x2="38.1" y2="134.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<pinref part="X2" gate="-2" pin="S"/>
<wire x1="91.44" y1="116.84" x2="38.1" y2="116.84" width="0.1524" layer="91"/>
<pinref part="X1" gate="-14" pin="S"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="X2" gate="-3" pin="S"/>
<wire x1="38.1" y1="119.38" x2="91.44" y2="119.38" width="0.1524" layer="91"/>
<pinref part="X1" gate="-13" pin="S"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="X2" gate="-4" pin="S"/>
<wire x1="91.44" y1="121.92" x2="38.1" y2="121.92" width="0.1524" layer="91"/>
<pinref part="X1" gate="-12" pin="S"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="X2" gate="-5" pin="S"/>
<wire x1="38.1" y1="124.46" x2="91.44" y2="124.46" width="0.1524" layer="91"/>
<pinref part="X1" gate="-11" pin="S"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports the association of 3D packages
with devices in libraries, schematics, and board files. Those 3D
packages will not be understood (or retained) with this version.
</note>
<note version="9.4" severity="warning">
Since Version 9.4, EAGLE supports the overriding of 3D packages
in schematics and board files. Those overridden 3d packages
will not be understood (or retained) with this version.
</note>
</compatibility>
</eagle>
