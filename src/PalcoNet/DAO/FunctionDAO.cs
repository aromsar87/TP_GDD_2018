﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class FunctionDAO
    {
        public Int32 Id { get; set; }
        public String Name { get; set; }
        public Boolean Visible { get; set; }

        public override string ToString()
        {
            return Name;
        }
    }

}
