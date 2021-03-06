﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MyLibrary;
using DAO;

namespace PalcoNet.Login
{
    public partial class Login : Form
    {
        int userId;
        string user;
        ContainerMain container;

        public Login(ContainerMain container)
        {
            InitializeComponent();
            this.container = container;
        }

        public void ClearFields()
        {
            this.txt_user.Text = "";
            this.txt_pass.Text = "";
        }

        public void EnableRoleSelection(bool state)
        {
            txt_user.Enabled = state;
            txt_pass.Enabled = state;
            cmb_rol.Visible = !state;
            lbl_rol.Visible = !state;
        }

        public string ValidateFields()
        {
            if (txt_user.Text.Length == 0)
            {
                return "Ingrese el Usuario";
            }

            if (txt_pass.Text.Length == 0)
            {
                return "Ingrese el Password";
            }

            return string.Empty;
        }

        private void InitSesion(int countRoles) 
        {
            this.userId = UserConnection.GetUserId(user);

            if (countRoles == 1)
            {
                Int32 roleId = UserConnection.getUniqueRolId(this.userId);
                this.openContainer(roleId);
            }

            if (countRoles > 1)
            {
                btn_init.Enabled = false;
                EnableRoleSelection(false);
                this.LoadCombo(userId);
            }
        }

        private void LoadCombo(Int32 userId)
        {
            SqlDataReader reader = UserConnection.GetRolesAvailables(userId);

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    RoleDAO role = new RoleDAO();
                    role.Id = reader.GetInt32(1);
                    role.Name = reader.GetString(0);
                    cmb_rol.Items.Add(role);
                }
            }

            reader.Close();
        }

        private void openContainer(Int32 roleId)
        {
            if (this.container == null)
            {
                ContainerMain otherContainer = new ContainerMain(this.userId, this.user, roleId);
                this.Hide();
                otherContainer.ShowDialog();
                this.Close();
            }
            else
            {
                this.Hide();
                this.container.id = this.userId;
                this.container.user = this.user;
                this.container.roleId = roleId;
                this.container.init(this.userId, this.user, roleId);
                this.container.Show();
                this.Close();
            }
        }

        private void btn_init_Click(object sender, EventArgs e)
        {
            string validationString = ValidateFields();

            if (validationString != string.Empty)
            {
                MessageBox.Show(validationString);
                return;
            }

            this.user = txt_user.Text.Trim();
            string pass = txt_pass.Text.Trim();
            int countRoles;

            int result = UserConnection.Authenticate(user, pass);

            switch (result)
            {

                case 0: MessageBox.Show("Usuario Inexistente");
                    ClearFields();
                    txt_user.Focus();
                    break;

                case 1: MessageBox.Show("Login incorrecto");
                    UserConnection.RegisterFailedAttempt(user);
                    ClearFields();
                    txt_user.Focus();
                    break;

                case 2: MessageBox.Show("Usuario Bloqueado. Por favor contáctese con el Administrador.");
                    this.Close();
                    break;

                case 3: countRoles = UserConnection.CountRoles(user);

                    if (countRoles == 0)
                    {
                        MessageBox.Show("No dispone de roles activos.");
                        this.Close();
                        return;
                    }
                    else
                    {
                        this.InitSesion(countRoles);
                    }

                    break;

                default: break;
            }
        }

        private void cmb_rol_SelectedIndexChanged(object sender, EventArgs e)
        {
            RoleDAO role = new RoleDAO();
            role = (RoleDAO) cmb_rol.SelectedItem;

            this.openContainer(role.Id);
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Environment.Exit(0);
        }
    }

}
