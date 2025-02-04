const { DataTypes } = require("sequelize");
const sequelize = require("../dbConfig");

const Guarantor = sequelize.define(
    "Guarantor",
    {
        guarantorId: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        guarantorName: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        guarantorNic: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true,
        },
        guarantorPhone: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        guarantorAddress: {
            type: DataTypes.STRING,
            allowNull: true,
        },
    },
    {
        tableName: "Guarantor",
        timestamps: false,
    }
);

module.exports = Guarantor;