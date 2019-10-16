using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ConApp_XmlDemos
{
    class DOM_ReadingXml_Demo
    {
        static void Main()
        {
            int no = 10;            
            Console.WriteLine(no);
            XmlDocument doc = new XmlDocument();            
            //You can use Path of xml file with the Load method
            doc.Load("Students.xml");
            /*
            //You can also use URL with the Load method
            doc.Load("http://localhost/MyWebSite/Students.xml");
            //You can also use I/O Stream with the Load method
            FileStream fs = new FileStream("Students.xml", FileMode.Open);
            doc.Load(fs);
            fs.Close();
            */
            XmlNodeList studentNodes = doc.DocumentElement.SelectNodes("/Students/Student");
            List<Student> studentList = new List<Student>();
            foreach (XmlNode node in studentNodes)
            {
                Student student = new Student()
                {
                    Name = node.SelectSingleNode("Name").InnerText,
                    Marks1 = float.Parse(node.SelectSingleNode("Marks").SelectSingleNode("Subject1").InnerText),
                    Marks2 = float.Parse(node.SelectSingleNode("Marks").SelectSingleNode("Subject2").InnerText),
                    Marks3 = float.Parse(node.SelectSingleNode("Marks").SelectSingleNode("Subject3").InnerText),
                    RollNo = int.Parse(node.Attributes["RollNo"].Value),
                    Avg = float.Parse(node.SelectSingleNode("AvgMarks").InnerText)
                };
                studentList.Add(student);
            }            


            foreach (Student student in studentList)
            {
                Console.WriteLine(student);
            }
        }
    }
}