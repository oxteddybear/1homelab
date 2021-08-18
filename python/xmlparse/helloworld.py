import xml.etree.ElementTree as ET
mytree = ET.parse('sample.xml')
myroot = mytree.getroot()
print(myroot.tag)
print(myroot.attrib)
print(myroot[0].tag)
