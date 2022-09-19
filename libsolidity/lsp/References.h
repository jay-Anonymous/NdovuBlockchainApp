/*
	This file is part of solidity.

	solidity is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	solidity is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with solidity.  If not, see <http://www.gnu.org/licenses/>.
*/
// SPDX-License-Identifier: GPL-3.0
#include <libsolidity/lsp/HandlerBase.h>
#include <libsolidity/lsp/Transport.h>

namespace solidity::lsp
{

/**
 * Implements JSON RPC for `textDocument/references`.
 */
class References: public HandlerBase
{
public:
	explicit References(LanguageServer& _server): HandlerBase(_server) {}

	void initialize(Json::Value const& _clientCapabilities, Json::Value& _replyCapabilities) override;
	void operator()(MessageID _id, Json::Value const& _args);
};

}
