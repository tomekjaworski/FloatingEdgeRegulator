<?xml version="1.0" encoding="UTF-8"?>
<ISO15745ProfileContainer xmlns="http://www.canopen.org/xml/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.canopen.org/xml/1.0 CANopen.xsd">
	<ISO15745Profile>
		<ProfileHeader>
			<ProfileIdentification>CAN device profile</ProfileIdentification>
			<ProfileRevision>1</ProfileRevision>
			<ProfileName></ProfileName>
			<ProfileSource></ProfileSource>
			<ProfileClassID>Device</ProfileClassID>
			<ISO15745Reference>
				<ISO15745Part>1</ISO15745Part>
				<ISO15745Edition>1</ISO15745Edition>
				<ProfileTechnology>CANopen</ProfileTechnology>
			</ISO15745Reference>
		</ProfileHeader>
		<ProfileBody xsi:type="ProfileBody_Device_CANopen" fileName="motor_configuration.xdc" fileCreator="FAULHABER Motion Manager 6" fileCreationDate="2021-03-11" fileCreationTime="11:07:34" fileModificationDate="2021-03-11" fileModificationTime="11:07:34" fileVersion="0x01" supportedLanguages="en" fileModifiedBy="FAULHABER Motion Manager 6">
			<DeviceIdentity>
				<vendorName readOnly="true">Faulhaber</vendorName>
				<vendorID readOnly="true">327</vendorID>
				<vendorText readOnly="true">
					<label lang="en"/>
				</vendorText>
				<deviceFamily readOnly="true">
					<label lang="en"/>
				</deviceFamily>
				<productFamily readOnly="true"></productFamily>
				<productName readOnly="true">MCDC-CF</productName>
				<productID readOnly="true">3150</productID>
				<productText readOnly="true">
					<description lang="en">FileDescription=Series MCDC-CF|EdsVersion=4.0|FileRevison=1|RevisionNum=1|Comments=Dr. Fritz Faulhaber GmbH &amp; Co KG
Daimlerstr. 23
71101 Schoenaich
http://www.faulhaber-group.com

EDS for Series MCDC-CF
with Firmware 605.3150.52-V|</description>
				</productText>
				<orderNumber readOnly="true"></orderNumber>
				<version versionType="SW" readOnly="true"></version>
				<version versionType="FW" readOnly="true"></version>
				<version versionType="HW" readOnly="true"></version>
				<specificationRevision readOnly="true"></specificationRevision>
				<instanceName readOnly="true"></instanceName>
			</DeviceIdentity>
			<DeviceManager>
				<indicatorList>
					<LEDList>
						<LED LEDcolors="monocolor" LEDtype="device">
							<label lang="en"/>
							<LEDstate uniqueID="LED_State_1" state="off" LEDcolor="green">
								<label lang="en"/>
							</LEDstate>
						</LED>
					</LEDList>
				</indicatorList>
			</DeviceManager>
			<DeviceFunction>
				<capabilities>
					<characteristicsList>
						<characteristic>
							<characteristicName>
								<label lang="en"/>
							</characteristicName>
							<characteristicContent>
								<label lang="en"/>
							</characteristicContent>
						</characteristic>
					</characteristicsList>
				</capabilities>
			</DeviceFunction>
			<ApplicationProcess>
				<parameterList>
					<parameter uniqueID="UID_PARAM_1000" access="const">
						<label lang="en">Device Type</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="131474"/><defaultValue value="0x00020192"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_1001" access="read">
						<label lang="en">Error Register</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_100301" access="read">
						<label lang="en">Standard Error Field</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="100"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_100302" access="read">
						<label lang="en">Standard Error Field</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="100"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_1005" access="readWrite">
						<label lang="en">COB-ID SYNC</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="128"/><defaultValue value="0x80"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_100c" access="readWrite">
						<label lang="en">Guard Time</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_100d" access="readWrite">
						<label lang="en">Life Time Factor</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_101001" access="readWrite">
						<label lang="en">Save All Parameters</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/></parameter>
					<parameter uniqueID="UID_PARAM_101002" access="readWrite">
						<label lang="en">Save Communication Parameters</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/></parameter>
					<parameter uniqueID="UID_PARAM_101003" access="readWrite">
						<label lang="en">Save Application Parameters</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/></parameter>
					<parameter uniqueID="UID_PARAM_101101" access="readWrite">
						<label lang="en">Restore All Parameters</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/></parameter>
					<parameter uniqueID="UID_PARAM_101102" access="readWrite">
						<label lang="en">Restore Communication Parameters</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/></parameter>
					<parameter uniqueID="UID_PARAM_101103" access="readWrite">
						<label lang="en">Restore Manufacture Parameters</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/></parameter>
					<parameter uniqueID="UID_PARAM_1014" access="read">
						<label lang="en">COB ID EMCY</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="133"/><defaultValue value="$NODEID+0x80"/>
						<allowedValues>
							<range>
								<minValue value="0x00000001"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_101801" access="read">
						<label lang="en">Vendor ID</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="327"/><defaultValue value="327"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_101802" access="read">
						<label lang="en">Product Code</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="3150"/><defaultValue value="3150"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_101803" access="read">
						<label lang="en">Revision number</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_101804" access="read">
						<label lang="en">Serial number</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="31400222"/></parameter>
					<parameter uniqueID="UID_PARAM_120001" access="read">
						<label lang="en">COB-ID Client-&gt;Server (Rx)</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1541"/><defaultValue value="$NODEID+0x600"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_120002" access="read">
						<label lang="en">COB-ID Server-&gt;Client (Tx)</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1413"/><defaultValue value="$NODEID+0x580"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_140001" access="read">
						<label lang="en">COB-ID Used by PDO</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="517"/><defaultValue value="$NODEID+0x200"/>
						<allowedValues>
							<range>
								<minValue value="0x00000001"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_140002" access="readWrite">
						<label lang="en">Transmission Type</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="255"/><defaultValue value="255"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_140101" access="read">
						<label lang="en">COB-ID used by PDO</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="773"/><defaultValue value="$NODEID+0x300"/>
						<allowedValues>
							<range>
								<minValue value="0x00000001"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_140102" access="readWrite">
						<label lang="en">Transmission Type</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="255"/><defaultValue value="255"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_140201" access="read">
						<label lang="en">COB-ID used by PDO</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1029"/><defaultValue value="$NODEID+0x400"/>
						<allowedValues>
							<range>
								<minValue value="0x00000001"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_140202" access="read">
						<label lang="en">Transmission Type</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="255"/><defaultValue value="255"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_160001" access="read">
						<label lang="en">PDO Mapping for the 1st Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1614807056"/><defaultValue value="0x60400010"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_160101" access="read">
						<label lang="en">PDO Mapping for the 1st Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587268360"/><defaultValue value="0x23010108"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_160102" access="read">
						<label lang="en">PDO Mapping for the 2nd Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587268640"/><defaultValue value="0x23010220"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_160201" access="read">
						<label lang="en">PDO Mapping for the 1st Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587399432"/><defaultValue value="0x23030108"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_160202" access="read">
						<label lang="en">PDO Mapping for the 2nd Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587399688"/><defaultValue value="0x23030208"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_160203" access="read">
						<label lang="en">PDO Mapping for the 3rd Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587399944"/><defaultValue value="0x23030308"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_160204" access="read">
						<label lang="en">PDO Mapping for the 4th Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587400200"/><defaultValue value="0x23030408"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_160205" access="read">
						<label lang="en">PDO Mapping for the 5th Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587400456"/><defaultValue value="0x23030508"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_180001" access="read">
						<label lang="en">COB-ID Used by PDO</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="389"/><defaultValue value="$NODEID+0x180"/>
						<allowedValues>
							<range>
								<minValue value="0x00000001"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_180002" access="readWrite">
						<label lang="en">Transmission Type</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="255"/><defaultValue value="255"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_180101" access="read">
						<label lang="en">COB-ID Used  by PDO</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="645"/><defaultValue value="$NODEID+0x280"/>
						<allowedValues>
							<range>
								<minValue value="0x00000001"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_180102" access="readWrite">
						<label lang="en">Transmission Type</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="253"/><defaultValue value="253"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_180201" access="read">
						<label lang="en">COB-ID Used  by PDO</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="901"/><defaultValue value="$NODEID+0x380"/>
						<allowedValues>
							<range>
								<minValue value="0x00000001"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_180202" access="readWrite">
						<label lang="en">Transmission Type</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="253"/><defaultValue value="253"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_1a0001" access="read">
						<label lang="en">PDO Mapping for the 1st Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1614872592"/><defaultValue value="0x60410010"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_1a0101" access="read">
						<label lang="en">PDO Mapping for the 1st Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587268360"/><defaultValue value="0x23010108"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_1a0102" access="read">
						<label lang="en">PDO Mapping for the 2nd Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587333920"/><defaultValue value="0x23020120"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_1a0103" access="read">
						<label lang="en">PDO Mapping for the 3rd Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587334152"/><defaultValue value="0x23020208"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_1a0201" access="read">
						<label lang="en">PDO Mapping for the 1st Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587464992"/><defaultValue value="0x23040120"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_1a0202" access="read">
						<label lang="en">PDO Mapping for the 2nd Application Object to be Mapped</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="587465248"/><defaultValue value="0x23040220"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_230101" access="readWrite">
						<label lang="en">Command Number</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="15"/><defaultValue value="0x00"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230102" access="readWriteInput">
						<label lang="en">Command Argument</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230201" access="read">
						<label lang="en">Command Result</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230202" access="read">
						<label lang="en">Error Code</label>
						<SINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-128"/>
								<maxValue value="127"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230301" access="readWriteInput">
						<label lang="en">1st Binary Data</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230302" access="readWriteInput">
						<label lang="en">2nd Binary Data</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230303" access="readWriteInput">
						<label lang="en">Time Flag Enable</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230304" access="readWriteInput">
						<label lang="en">Number Of Requested Packets</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230305" access="readWriteInput">
						<label lang="en">Distance Between Requested Packets</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230401" access="read">
						<label lang="en">1st Packet Result</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230402" access="read">
						<label lang="en">2nd Packet Result</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFFFFFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_230403" access="read">
						<label lang="en">Timecode</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="255"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_231001" access="readWriteInput">
						<label lang="en">Homing Negative Limit</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x00"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_231002" access="readWriteInput">
						<label lang="en">Homing Positive Limit</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x00"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_231003" access="readWriteInput">
						<label lang="en">Homing Switch</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x00"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_231004" access="readWriteInput">
						<label lang="en">Notify Switch</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x00"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_231005" access="readWriteInput">
						<label lang="en">Switch Polarity</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="27"/><defaultValue value="0x1F"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_231006" access="readWriteInput">
						<label lang="en">Switch Polarity Enable in Homing</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x00"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_2311" access="read">
						<label lang="en">Notify Status</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x00"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0x0F"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_232001" access="read">
						<label lang="en">Internal Fault Register</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x0000"/>
						<allowedValues>
							<range>
								<minValue value="0x0000"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_232002" access="readWriteInput">
						<label lang="en">Emergency Switches</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="255"/><defaultValue value="0x00FF"/>
						<allowedValues>
							<range>
								<minValue value="0x0000"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_232003" access="readWriteInput">
						<label lang="en">Fault Switches</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x0000"/>
						<allowedValues>
							<range>
								<minValue value="0x0000"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_232004" access="readWriteInput">
						<label lang="en">Error Outputs</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="255"/><defaultValue value="0x00FF"/>
						<allowedValues>
							<range>
								<minValue value="0x0000"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_2400" access="read">
						<label lang="en">Baudrate</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="7"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xff"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_2401" access="readWriteInput">
						<label lang="en">Set of Special Configurations</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x0000"/>
					</parameter>
					<parameter uniqueID="UID_PARAM_2403" access="readWriteInput">
						<label lang="en">Special Settings</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x0000"/>
						<allowedValues>
							<range>
								<minValue value="0x0000"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_2404" access="readWriteInput">
						<label lang="en">Service Settings</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x0000"/>
						<allowedValues>
							<range>
								<minValue value="0x0000"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6040" access="readWriteInput">
						<label lang="en">Controlword</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="15"/><defaultValue value="0x0000"/>
						<allowedValues>
							<range>
								<minValue value="0x0000"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6041" access="read">
						<label lang="en">Statusword</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="39"/><defaultValue value="0x0000"/>
						<allowedValues>
							<range>
								<minValue value="0x0000"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6060" access="readWriteInput">
						<label lang="en">Modes Of Operation</label>
						<SINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="-1"/>
								<maxValue value="6"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6061" access="read">
						<label lang="en">Modes Of Operation Display</label>
						<SINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6062" access="read">
						<label lang="en">Position Demand Value</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6063" access="read">
						<label lang="en">Position Actual Internal Value</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-1800000000"/>
								<maxValue value="1800000000"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6064" access="read">
						<label lang="en">Position Actual Value</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6067" access="readWriteInput">
						<label lang="en">Position Window</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="200"/><defaultValue value="20"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6068" access="readWriteInput">
						<label lang="en">Position Window Time</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="200"/><defaultValue value="200"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6069" access="read">
						<label lang="en">Velocity Sensor Actual Value</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_606b" access="read">
						<label lang="en">Velocity Demand Value</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_606c" access="read">
						<label lang="en">Velocity Actual Value</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_606d" access="readWriteInput">
						<label lang="en">Velocity Window</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="20"/><defaultValue value="20"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_606e" access="readWriteInput">
						<label lang="en">Velocity Window Time</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="200"/><defaultValue value="200"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_606f" access="readWriteInput">
						<label lang="en">Velocity Threshold</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="20"/><defaultValue value="20"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6070" access="readWriteInput">
						<label lang="en">Velocity Threshold Time</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="200"/><defaultValue value="200"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_607a" access="readWriteInput">
						<label lang="en">Target Position</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483647"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_607c" access="readWriteInput">
						<label lang="en">Home Offset</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-1800000000"/>
								<maxValue value="1800000000"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_607d01" access="readWriteInput">
						<label lang="en">Negative Position Limit</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-100000"/><defaultValue value="-1800000000"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_607d02" access="readWriteInput">
						<label lang="en">Positive Position Limit</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="400000"/><defaultValue value="1800000000"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_607e" access="readWriteInput">
						<label lang="en">Polarity</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0x00"/>
						<allowedValues>
							<range>
								<minValue value="0x00"/>
								<maxValue value="0xFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_607f" access="readWriteInput">
						<label lang="en">Max Profile Velocity</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="2000"/><defaultValue value="30000"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6081" access="readWriteInput">
						<label lang="en">Profile Velocity</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="2000"/><defaultValue value="30000"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6083" access="readWriteInput">
						<label lang="en">Profile Acceleration</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1000"/><defaultValue value="30000"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6084" access="readWriteInput">
						<label lang="en">Profile Deceleration</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1000"/><defaultValue value="30000"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6085" access="readWriteInput">
						<label lang="en">Quick Stop Deceleration</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="30000"/><defaultValue value="30000"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6086" access="readWriteInput">
						<label lang="en">Motion Profile Type</label>
						<INT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="0"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_608f01" access="readWrite">
						<label lang="en">Encoder Increments</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="4096"/><defaultValue value="2048"/>
						<allowedValues>
							<range>
								<minValue value="8"/>
								<maxValue value="0xFFFF"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_608f02" access="read">
						<label lang="en">Motor Revolutions</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="1"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609301" access="readWriteInput">
						<label lang="en">Numerator</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="65536"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609302" access="readWriteInput">
						<label lang="en">Divisor</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="65536"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609601" access="readWriteInput">
						<label lang="en">Numerator</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="65536"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609602" access="readWriteInput">
						<label lang="en">Divisor</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="65536"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609701" access="readWriteInput">
						<label lang="en">Numerator</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="65536"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609702" access="readWriteInput">
						<label lang="en">Divisor</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1"/><defaultValue value="1"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="65536"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_6098" access="readWriteInput">
						<label lang="en">Homing Method</label>
						<SINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="19"/><defaultValue value="20"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="35"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609901" access="readWriteInput">
						<label lang="en">Switch Seek Velocity</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1000"/><defaultValue value="400"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609902" access="readWriteInput">
						<label lang="en">Homing Velocity</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="1000"/><defaultValue value="100"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_609a" access="readWriteInput">
						<label lang="en">Homing Acceleration</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="500"/><defaultValue value="50"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_60f901" access="readWriteInput">
						<label lang="en">P</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="3"/><defaultValue value="10"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_60f902" access="readWriteInput">
						<label lang="en">I</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="20"/><defaultValue value="50"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_60fa" access="read">
						<label lang="en">Control Effort</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-32768"/>
								<maxValue value="32767"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_60fb01" access="readWriteInput">
						<label lang="en">PP</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="12"/><defaultValue value="10"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_60fb02" access="readWriteInput">
						<label lang="en">PD</label>
						<USINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="2"/><defaultValue value="5"/>
						<allowedValues>
							<range>
								<minValue value="1"/>
								<maxValue value="255"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_60fc" access="read">
						<label lang="en">Position Demand Internal Value</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-1800000000"/>
								<maxValue value="1800000000"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_60ff" access="readWriteInput">
						<label lang="en">Target Velocity</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="0"/><defaultValue value="0"/>
						<allowedValues>
							<range>
								<minValue value="-2147483648"/>
								<maxValue value="2147483647"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_651001" access="read">
						<label lang="en">Motor Type</label>
						<DINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="-1"/><defaultValue value="-1"/>
						<allowedValues>
							<range>
								<minValue value="-1"/>
								<maxValue value="9"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_651002" access="readWriteInput">
						<label lang="en">Kn</label>
						<UINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="225"/><defaultValue value="14000"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="16383"/>
							</range>
						</allowedValues>
					</parameter>
					<parameter uniqueID="UID_PARAM_651003" access="readWriteInput">
						<label lang="en">Rm</label>
						<UDINT/>
						<denotation>
							<label lang="en"></label>
						</denotation>
						<actualValue value="360"/><defaultValue value="200000"/>
						<allowedValues>
							<range>
								<minValue value="0"/>
								<maxValue value="320000"/>
							</range>
						</allowedValues>
					</parameter>
				</parameterList>
			</ApplicationProcess>
		</ProfileBody>
	</ISO15745Profile>
	<ISO15745Profile>
		<ProfileHeader>
			<ProfileIdentification>CAN comm net profile</ProfileIdentification>
			<ProfileRevision>1</ProfileRevision>
			<ProfileName></ProfileName>
			<ProfileSource></ProfileSource>
			<ProfileClassID>CommunicationNetwork</ProfileClassID>
			<ISO15745Reference>
				<ISO15745Part>1</ISO15745Part>
				<ISO15745Edition>1</ISO15745Edition>
				<ProfileTechnology>CANopen</ProfileTechnology>
			</ISO15745Reference>
		</ProfileHeader>
		<ProfileBody xsi:type="ProfileBody_CommunicationNetwork_CANopen" fileName="motor_configuration.xdc" fileCreator="FAULHABER Motion Manager 6" fileCreationDate="2021-03-11" fileCreationTime="11:07:34" fileModificationDate="2021-03-11" fileModificationTime="11:07:34" fileVersion="0x01" supportedLanguages="en" fileModifiedBy="FAULHABER Motion Manager 6">
			<ApplicationLayers>
				<identity>
					<vendorID>327</vendorID>
					<productID>3150</productID>
				</identity>
				<CANopenObjectList>
					<CANopenObject index="1000" name="Device Type" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1000"/>
					<CANopenObject index="1001" name="Error Register" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_1001"/>
					<CANopenObject index="1003" name="Pre-defined Error Field" objectType="8" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Errors" objectType="7" dataType="0005" lowLimit="0" highLimit="0" accessType="rw" defaultValue="0" PDOmapping="no" actualValue="0"/>
						<CANopenSubObject subIndex="01" name="Standard Error Field" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_100301"/>
						<CANopenSubObject subIndex="02" name="Standard Error Field" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_100302"/>
					</CANopenObject>
					<CANopenObject index="1005" name="COB-ID SYNC" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1005"/>
					<CANopenObject index="1008" name="Manufacturer Device Name" objectType="7" dataType="0009" accessType="const" PDOmapping="no" actualValue="MCDC3006S-CF"/>
					<CANopenObject index="1009" name="Manufacturer Hardware Version" objectType="7" dataType="0009" accessType="const" PDOmapping="no" actualValue="601.3157.02"/>
					<CANopenObject index="100A" name="Manufacturer Software Version" objectType="7" dataType="0009" accessType="const" PDOmapping="no" actualValue="3150.52V"/>
					<CANopenObject index="100C" name="Guard Time" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_100c"/>
					<CANopenObject index="100D" name="Life Time Factor" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_100d"/>
					<CANopenObject index="1010" name="Store Parameters" objectType="8" subNumber="4">
						<CANopenSubObject subIndex="00" name="Largest Supported Sub-index" objectType="7" dataType="0005" lowLimit="3" highLimit="3" accessType="ro" defaultValue="3" PDOmapping="no" actualValue="3"/>
						<CANopenSubObject subIndex="01" name="Save All Parameters" objectType="7" dataType="0007" PDOmapping="no" objFlags="0001" uniqueIDRef="UID_PARAM_101001"/>
						<CANopenSubObject subIndex="02" name="Save Communication Parameters" objectType="7" dataType="0007" PDOmapping="no" objFlags="0001" uniqueIDRef="UID_PARAM_101002"/>
						<CANopenSubObject subIndex="03" name="Save Application Parameters" objectType="7" dataType="0007" PDOmapping="no" objFlags="0001" uniqueIDRef="UID_PARAM_101003"/>
					</CANopenObject>
					<CANopenObject index="1011" name="Restore  Parameters" objectType="8" subNumber="4">
						<CANopenSubObject subIndex="00" name="Largest Supported Sub-index" objectType="7" dataType="0005" accessType="ro" defaultValue="3" PDOmapping="no" actualValue="3"/>
						<CANopenSubObject subIndex="01" name="Restore All Parameters" objectType="7" dataType="0007" PDOmapping="no" objFlags="0001" uniqueIDRef="UID_PARAM_101101"/>
						<CANopenSubObject subIndex="02" name="Restore Communication Parameters" objectType="7" dataType="0007" PDOmapping="no" objFlags="0001" uniqueIDRef="UID_PARAM_101102"/>
						<CANopenSubObject subIndex="03" name="Restore Manufacture Parameters" objectType="7" dataType="0007" PDOmapping="no" objFlags="0001" uniqueIDRef="UID_PARAM_101103"/>
					</CANopenObject>
					<CANopenObject index="1014" name="COB ID EMCY" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1014"/>
					<CANopenObject index="1018" name="Identity Object" objectType="9" subNumber="5">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" accessType="ro" defaultValue="4" PDOmapping="no" actualValue="4"/>
						<CANopenSubObject subIndex="01" name="Vendor ID" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_101801"/>
						<CANopenSubObject subIndex="02" name="Product Code" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_101802"/>
						<CANopenSubObject subIndex="03" name="Revision number" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_101803"/>
						<CANopenSubObject subIndex="04" name="Serial number" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_101804"/>
					</CANopenObject>
					<CANopenObject index="1200" name="1st Server SDO Parameter" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="2" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="COB-ID Client-&gt;Server (Rx)" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_120001"/>
						<CANopenSubObject subIndex="02" name="COB-ID Server-&gt;Client (Tx)" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_120002"/>
					</CANopenObject>
					<CANopenObject index="1400" name="1st Receive PDO Parameter" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Largest Sub-Index Supported" objectType="7" dataType="0005" lowLimit="2" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="COB-ID Used by PDO" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_140001"/>
						<CANopenSubObject subIndex="02" name="Transmission Type" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_140002"/>
					</CANopenObject>
					<CANopenObject index="1401" name="2nd Receive PDO parameter" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="2" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="COB-ID used by PDO" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_140101"/>
						<CANopenSubObject subIndex="02" name="Transmission Type" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_140102"/>
					</CANopenObject>
					<CANopenObject index="1402" name="3rd Receive PDO Parameters" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="2" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="COB-ID used by PDO" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_140201"/>
						<CANopenSubObject subIndex="02" name="Transmission Type" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_140202"/>
					</CANopenObject>
					<CANopenObject index="1600" name="1st Receive PDO Mapping" objectType="9" subNumber="2">
						<CANopenSubObject subIndex="00" name="Number Of Mapped Application Objects In PDO" objectType="7" dataType="0005" lowLimit="0" highLimit="1" accessType="ro" defaultValue="1" PDOmapping="no" actualValue="1"/>
						<CANopenSubObject subIndex="01" name="PDO Mapping for the 1st Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_160001"/>
					</CANopenObject>
					<CANopenObject index="1601" name="2nd Receive PDO Mapping" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Mapped Application Objects In PDO" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="PDO Mapping for the 1st Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_160101"/>
						<CANopenSubObject subIndex="02" name="PDO Mapping for the 2nd Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_160102"/>
					</CANopenObject>
					<CANopenObject index="1602" name="3rd Receive PDO Mapping" objectType="9" subNumber="6">
						<CANopenSubObject subIndex="00" name="Number Of Mapped Application Objects In PDO" objectType="7" dataType="0005" lowLimit="0" highLimit="5" accessType="ro" defaultValue="5" PDOmapping="no" actualValue="5"/>
						<CANopenSubObject subIndex="01" name="PDO Mapping for the 1st Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_160201"/>
						<CANopenSubObject subIndex="02" name="PDO Mapping for the 2nd Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_160202"/>
						<CANopenSubObject subIndex="03" name="PDO Mapping for the 3rd Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_160203"/>
						<CANopenSubObject subIndex="04" name="PDO Mapping for the 4th Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_160204"/>
						<CANopenSubObject subIndex="05" name="PDO Mapping for the 5th Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_160205"/>
					</CANopenObject>
					<CANopenObject index="1800" name="1st Transmit PDO Parameter" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Largest Sub-Index Supported" objectType="7" dataType="0005" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="COB-ID Used by PDO" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_180001"/>
						<CANopenSubObject subIndex="02" name="Transmission Type" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_180002"/>
					</CANopenObject>
					<CANopenObject index="1801" name="2nd Transmit PDO Parameter" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Largest Sub-Index Supported" objectType="7" dataType="0005" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="COB-ID Used  by PDO" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_180101"/>
						<CANopenSubObject subIndex="02" name="Transmission Type" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_180102"/>
					</CANopenObject>
					<CANopenObject index="1802" name="3rd Transmit PDO Parameter" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Largest Sub-Index Supported" objectType="7" dataType="0005" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="COB-ID Used  by PDO" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_180201"/>
						<CANopenSubObject subIndex="02" name="Transmission Type" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_180202"/>
					</CANopenObject>
					<CANopenObject index="1A00" name="1st Transmit PDO Mapping" objectType="9" subNumber="2">
						<CANopenSubObject subIndex="00" name="Number Of Mapped Application Objects In PDO" objectType="7" dataType="0005" lowLimit="0" highLimit="1" accessType="ro" defaultValue="1" PDOmapping="no" actualValue="1"/>
						<CANopenSubObject subIndex="01" name="PDO Mapping for the 1st Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1a0001"/>
					</CANopenObject>
					<CANopenObject index="1A01" name="2nd Transmit PDO Mapping" objectType="9" subNumber="4">
						<CANopenSubObject subIndex="00" name="Number Of Mapped Application Objects In PDO" objectType="7" dataType="0005" lowLimit="0" highLimit="3" accessType="ro" defaultValue="3" PDOmapping="no" actualValue="3"/>
						<CANopenSubObject subIndex="01" name="PDO Mapping for the 1st Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1a0101"/>
						<CANopenSubObject subIndex="02" name="PDO Mapping for the 2nd Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1a0102"/>
						<CANopenSubObject subIndex="03" name="PDO Mapping for the 3rd Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1a0103"/>
					</CANopenObject>
					<CANopenObject index="1A02" name="3rd Transmit PDO  Mapping" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Mapped Application Objects In PDO" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="PDO Mapping for the 1st Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1a0201"/>
						<CANopenSubObject subIndex="02" name="PDO Mapping for the 2nd Application Object to be Mapped" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_1a0202"/>
					</CANopenObject>
					<CANopenObject index="2301" name="FAULHABER Command" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="Command Number" objectType="7" dataType="0005" PDOmapping="optional" uniqueIDRef="UID_PARAM_230101"/>
						<CANopenSubObject subIndex="02" name="Command Argument" objectType="7" dataType="0004" PDOmapping="RPDO" uniqueIDRef="UID_PARAM_230102"/>
					</CANopenObject>
					<CANopenObject index="2302" name="FAULHABER Command Answer" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="Command Result" objectType="7" dataType="0004" PDOmapping="TPDO" uniqueIDRef="UID_PARAM_230201"/>
						<CANopenSubObject subIndex="02" name="Error Code" objectType="7" dataType="0002" PDOmapping="TPDO" uniqueIDRef="UID_PARAM_230202"/>
					</CANopenObject>
					<CANopenObject index="2303" name="Trace Configuration" objectType="9" subNumber="6">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="5" accessType="ro" defaultValue="5" PDOmapping="no" actualValue="5"/>
						<CANopenSubObject subIndex="01" name="1st Binary Data" objectType="7" dataType="0005" PDOmapping="RPDO" uniqueIDRef="UID_PARAM_230301"/>
						<CANopenSubObject subIndex="02" name="2nd Binary Data" objectType="7" dataType="0005" PDOmapping="RPDO" uniqueIDRef="UID_PARAM_230302"/>
						<CANopenSubObject subIndex="03" name="Time Flag Enable" objectType="7" dataType="0005" PDOmapping="RPDO" uniqueIDRef="UID_PARAM_230303"/>
						<CANopenSubObject subIndex="04" name="Number Of Requested Packets" objectType="7" dataType="0005" PDOmapping="RPDO" uniqueIDRef="UID_PARAM_230304"/>
						<CANopenSubObject subIndex="05" name="Distance Between Requested Packets" objectType="7" dataType="0005" PDOmapping="RPDO" uniqueIDRef="UID_PARAM_230305"/>
					</CANopenObject>
					<CANopenObject index="2304" name="Trace Data" objectType="9" subNumber="4">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="3" accessType="ro" defaultValue="3" PDOmapping="no" actualValue="3"/>
						<CANopenSubObject subIndex="01" name="1st Packet Result" objectType="7" dataType="0007" PDOmapping="TPDO" uniqueIDRef="UID_PARAM_230401"/>
						<CANopenSubObject subIndex="02" name="2nd Packet Result" objectType="7" dataType="0007" PDOmapping="TPDO" uniqueIDRef="UID_PARAM_230402"/>
						<CANopenSubObject subIndex="03" name="Timecode" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_230403"/>
					</CANopenObject>
					<CANopenObject index="2310" name="Switch Settings" objectType="9" subNumber="7">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="6" accessType="ro" defaultValue="6" PDOmapping="no" actualValue="6"/>
						<CANopenSubObject subIndex="01" name="Homing Negative Limit" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_231001"/>
						<CANopenSubObject subIndex="02" name="Homing Positive Limit" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_231002"/>
						<CANopenSubObject subIndex="03" name="Homing Switch" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_231003"/>
						<CANopenSubObject subIndex="04" name="Notify Switch" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_231004"/>
						<CANopenSubObject subIndex="05" name="Switch Polarity" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_231005"/>
						<CANopenSubObject subIndex="06" name="Switch Polarity Enable in Homing" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_231006"/>
					</CANopenObject>
					<CANopenObject index="2311" name="Notify Status" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_2311"/>
					<CANopenObject index="2320" name="FAULHABER Fault Register" objectType="9" subNumber="5">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="4" accessType="ro" defaultValue="4" PDOmapping="no" actualValue="4"/>
						<CANopenSubObject subIndex="01" name="Internal Fault Register" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_232001"/>
						<CANopenSubObject subIndex="02" name="Emergency Switches" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_232002"/>
						<CANopenSubObject subIndex="03" name="Fault Switches" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_232003"/>
						<CANopenSubObject subIndex="04" name="Error Outputs" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_232004"/>
					</CANopenObject>
					<CANopenObject index="2400" name="Baudrate" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_2400"/>
					<CANopenObject index="2401" name="Set of Special Configurations" objectType="7" dataType="0006" PDOmapping="no" objFlags="0002" uniqueIDRef="UID_PARAM_2401"/>
					<CANopenObject index="2403" name="Special Settings" objectType="7" dataType="0006" PDOmapping="no" objFlags="0002" uniqueIDRef="UID_PARAM_2403"/>
					<CANopenObject index="2404" name="Service Settings" objectType="7" dataType="0006" PDOmapping="no" objFlags="0002" uniqueIDRef="UID_PARAM_2404"/>
					<CANopenObject index="6040" name="Controlword" objectType="7" dataType="0006" PDOmapping="RPDO" uniqueIDRef="UID_PARAM_6040"/>
					<CANopenObject index="6041" name="Statusword" objectType="7" dataType="0006" PDOmapping="TPDO" uniqueIDRef="UID_PARAM_6041"/>
					<CANopenObject index="6060" name="Modes Of Operation" objectType="7" dataType="0002" PDOmapping="no" uniqueIDRef="UID_PARAM_6060"/>
					<CANopenObject index="6061" name="Modes Of Operation Display" objectType="7" dataType="0002" PDOmapping="no" uniqueIDRef="UID_PARAM_6061"/>
					<CANopenObject index="6062" name="Position Demand Value" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_6062"/>
					<CANopenObject index="6063" name="Position Actual Internal Value" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_6063"/>
					<CANopenObject index="6064" name="Position Actual Value" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_6064"/>
					<CANopenObject index="6067" name="Position Window" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_6067"/>
					<CANopenObject index="6068" name="Position Window Time" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_6068"/>
					<CANopenObject index="6069" name="Velocity Sensor Actual Value" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_6069"/>
					<CANopenObject index="606B" name="Velocity Demand Value" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_606b"/>
					<CANopenObject index="606C" name="Velocity Actual Value" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_606c"/>
					<CANopenObject index="606D" name="Velocity Window" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_606d"/>
					<CANopenObject index="606E" name="Velocity Window Time" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_606e"/>
					<CANopenObject index="606F" name="Velocity Threshold" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_606f"/>
					<CANopenObject index="6070" name="Velocity Threshold Time" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_6070"/>
					<CANopenObject index="607A" name="Target Position" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_607a"/>
					<CANopenObject index="607C" name="Home Offset" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_607c"/>
					<CANopenObject index="607D" name="Software Position Limit" objectType="8" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="Negative Position Limit" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_607d01"/>
						<CANopenSubObject subIndex="02" name="Positive Position Limit" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_607d02"/>
					</CANopenObject>
					<CANopenObject index="607E" name="Polarity" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_607e"/>
					<CANopenObject index="607F" name="Max Profile Velocity" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_607f"/>
					<CANopenObject index="6081" name="Profile Velocity" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_6081"/>
					<CANopenObject index="6083" name="Profile Acceleration" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_6083"/>
					<CANopenObject index="6084" name="Profile Deceleration" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_6084"/>
					<CANopenObject index="6085" name="Quick Stop Deceleration" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_6085"/>
					<CANopenObject index="6086" name="Motion Profile Type" objectType="7" dataType="0003" PDOmapping="no" uniqueIDRef="UID_PARAM_6086"/>
					<CANopenObject index="608F" name="Position Encoder Resolution" objectType="8" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="Encoder Increments" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_608f01"/>
						<CANopenSubObject subIndex="02" name="Motor Revolutions" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_608f02"/>
					</CANopenObject>
					<CANopenObject index="6093" name="Position Factor" objectType="8" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="Numerator" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609301"/>
						<CANopenSubObject subIndex="02" name="Divisor" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609302"/>
					</CANopenObject>
					<CANopenObject index="6096" name="Velocity Factor" objectType="8" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="Numerator" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609601"/>
						<CANopenSubObject subIndex="02" name="Divisor" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609602"/>
					</CANopenObject>
					<CANopenObject index="6097" name="Acceleration Factor" objectType="8" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="Numerator" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609701"/>
						<CANopenSubObject subIndex="02" name="Divisor" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609702"/>
					</CANopenObject>
					<CANopenObject index="6098" name="Homing Method" objectType="7" dataType="0002" PDOmapping="no" uniqueIDRef="UID_PARAM_6098"/>
					<CANopenObject index="6099" name="Homing Velocities" objectType="8" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="Switch Seek Velocity" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609901"/>
						<CANopenSubObject subIndex="02" name="Homing Velocity" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609902"/>
					</CANopenObject>
					<CANopenObject index="609A" name="Homing Acceleration" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_609a"/>
					<CANopenObject index="60F9" name="Velocity Control Parameter Set" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="P" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_60f901"/>
						<CANopenSubObject subIndex="02" name="I" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_60f902"/>
					</CANopenObject>
					<CANopenObject index="60FA" name="Control Effort" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_60fa"/>
					<CANopenObject index="60FB" name="Position Control Parameter Set" objectType="9" subNumber="3">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="2" accessType="ro" defaultValue="2" PDOmapping="no" actualValue="2"/>
						<CANopenSubObject subIndex="01" name="PP" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_60fb01"/>
						<CANopenSubObject subIndex="02" name="PD" objectType="7" dataType="0005" PDOmapping="no" uniqueIDRef="UID_PARAM_60fb02"/>
					</CANopenObject>
					<CANopenObject index="60FC" name="Position Demand Internal Value" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_60fc"/>
					<CANopenObject index="60FF" name="Target Velocity" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_60ff"/>
					<CANopenObject index="6510" name="Drive Data" objectType="9" subNumber="4">
						<CANopenSubObject subIndex="00" name="Number Of Entries" objectType="7" dataType="0005" lowLimit="0" highLimit="3" accessType="ro" defaultValue="3" PDOmapping="no" actualValue="3"/>
						<CANopenSubObject subIndex="01" name="Motor Type" objectType="7" dataType="0004" PDOmapping="no" uniqueIDRef="UID_PARAM_651001"/>
						<CANopenSubObject subIndex="02" name="Kn" objectType="7" dataType="0006" PDOmapping="no" uniqueIDRef="UID_PARAM_651002"/>
						<CANopenSubObject subIndex="03" name="Rm" objectType="7" dataType="0007" PDOmapping="no" uniqueIDRef="UID_PARAM_651003"/>
					</CANopenObject>
				</CANopenObjectList>
				<dummyUsage>
					<dummy entry="Dummy0001=0"/>
					<dummy entry="Dummy0002=0"/>
					<dummy entry="Dummy0003=0"/>
					<dummy entry="Dummy0004=0"/>
					<dummy entry="Dummy0005=0"/>
					<dummy entry="Dummy0006=0"/>
					<dummy entry="Dummy0007=0"/>
				</dummyUsage>
			</ApplicationLayers>
			<TransportLayers>
				<PhysicalLayer>
					<baudRate defaultValue="auto-baudRate">
						<supportedBaudRate value="10 Kbps"/>
						<supportedBaudRate value="20 Kbps"/>
						<supportedBaudRate value="50 Kbps"/>
						<supportedBaudRate value="125 Kbps"/>
						<supportedBaudRate value="250 Kbps"/>
						<supportedBaudRate value="500 Kbps"/>
						<supportedBaudRate value="800 Kbps"/>
						<supportedBaudRate value="1000 Kbps"/>
					</baudRate>
				</PhysicalLayer>
			</TransportLayers>
			<NetworkManagement>
				<CANopenGeneralFeatures groupMessaging="false" dynamicChannels="0" selfStartingDevice="false" SDORequestingDevice="false" granularity="0" nrOfRxPDO="3" nrOfTxPDO="3" bootUpSlave="true" layerSettingServiceSlave="true"/>
				<CANopenMasterFeatures bootUpMaster="false" flyingMaster="false" SDOManager="false" configurationManager="false" layerSettingServiceMaster="true"/>
				<deviceCommissioning nodeID="0" nodeName="" actualBaudRate="125" networkNumber="0" networkName="" CANopenManager="false"/>
			</NetworkManagement>
		</ProfileBody>
	</ISO15745Profile>
</ISO15745ProfileContainer>
