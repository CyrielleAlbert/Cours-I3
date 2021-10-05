# -*- coding: utf-8 -*-

import empro.toolkit.adv as adv

def main():
	path=r"Z:/Documents/Cours-I3/antenne/PatchAntenna"
	lib=r"PatchAntenna_lib"
	subst=r"PatchAntenna_lib/substrate1.subst"
	substlib=r"PatchAntenna_lib"
	substname=r"substrate1"
	cell=r"cell_1"
	view=r"layout"
	libS3D=r"simulation/PatchAntenna_lib/cell_1/_3%D%Viewer/extra/0/proj_libS3D.xml"
	varDictionary={}
	exprDictionary={}
	adv.loadDesign(path=path, lib=lib, subst=subst, substlib=substlib, substname=substname, cell=cell, view=view, libS3D=libS3D, var_dict=varDictionary, expr_dict=exprDictionary)
