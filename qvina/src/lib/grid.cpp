// =---------------------------------------------------------------------= //
// grid.cpp
// COPYRIGHT FUJITSU LIMITED 2023
//
// |     Date     |     Author      |     Contents                        |
// +--------------+-----------------+-------------------------------------+
// |  2023.06.26  | Shingo Takizawa | Inlined grid::evaluate_aux function |
// |              |                 | into evaluate function.             |
//
// =---------------------------------------------------------------------= //

/*

   Copyright (c) 2006-2010, The Scripps Research Institute

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

   Author: Dr. Oleg Trott <ot14@columbia.edu>, 
           The Olson Lab, 
           The Scripps Research Institute

*/

#include "grid.h"

void grid::init(const grid_dims& gd) {
	m_data.resize(gd[0].n+1, gd[1].n+1, gd[2].n+1);
	m_init = vec(gd[0].begin, gd[1].begin, gd[2].begin);
	m_range = vec(gd[0].span(), gd[1].span(), gd[2].span());
	assert(m_range[0] > 0);
	assert(m_range[1] > 0);
	assert(m_range[2] > 0);
	m_dim_fl_minus_1 = vec(m_data.dim0() - 1.0, 
	                       m_data.dim1() - 1.0,
			               m_data.dim2() - 1.0);
	VINA_FOR(i, 3) {
		m_factor[i] = m_dim_fl_minus_1[i] / m_range[i];
		m_factor_inv[i] = 1 / m_factor[i];
	}
}
