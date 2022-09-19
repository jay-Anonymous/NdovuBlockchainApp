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
#pragma once

#include <libsolidity/ast/ASTForward.h>
#include <libsolidity/ast/ASTVisitor.h>

namespace solidity::lsp
{

/**
 * See https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#documentHighlightKind
 */
enum class DocumentHighlightKind
{
	Unspecified = 0,    //!< could be for example a highlight found in a comment
	Text = 1,           //!< a textual occurrence
	Read = 2,           //!< read access to a variable
	Write = 3,          //!< write access to a variable
};

/**
 * Represents a symbol / AST node that is to be highlighted, with some context associated.
 */
using Reference = std::tuple<langutil::SourceLocation, DocumentHighlightKind>;

/**
 * ReferenceCollector can be used to collect all source locations and their usage
 * of a given symbol in the AST tree.
 */
class ReferenceCollector: public frontend::ASTConstVisitor
{
private:
	ReferenceCollector(frontend::Declaration const& _declaration, int _sourceOffset, std::string const& _sourceIdentifierName = "");

	/// Collects all occurrences of a given identifier matching the same declaration.
	/// Just passing the AST node and infer the name from there is not enough as they might have been aliased.
	///
	/// @param _declaration the declaration to match against for the symbols to collect
	/// @param _sourceOffset byte offset into the respective file reflecting the exact location of the cursor
	/// @param _astSearchRoot the AST base root node to start the recursive traversal to collect the references
	/// @param _sourceIdentifierName the symbolic name that must match, which is explicitly given as it might have been altered due to aliases.
	///
	/// @returns a vector of Reference objects that contain the source location of each match as well as their
	/// semantic use (e.g. read access or write access).
	static std::vector<Reference> collect(
		frontend::Declaration const* _declaration,
		int _sourceOffset,
		frontend::ASTNode const& _astSearchRoot,
		std::string const& _sourceIdentifierName
	);

public:
	/// Collects all references (symbols with the same matching declaration as @p _sourceNode) in the given source unit.
	static std::vector<Reference> collect(frontend::ASTNode const* _sourceNode, int _sourceOffset, frontend::SourceUnit const& _sourceUnit);

	bool visit(frontend::ImportDirective const& _import) override;
	void endVisit(frontend::Identifier const& _identifier) override;
	void endVisit(frontend::IdentifierPath  const& _identifierPath) override;
	void endVisit(frontend::MemberAccess const& _memberAccess) override;
	bool visit(frontend::Assignment const& _node) override;
	bool visit(frontend::VariableDeclaration const& _node) override;
	bool visitNode(frontend::ASTNode const& _node) override;

private:
	frontend::Declaration const& m_declaration;
	int m_sourceOffset;
	std::string const& m_sourceIdentifierName;
	std::vector<Reference> m_collectedReferences;
	DocumentHighlightKind m_kind = DocumentHighlightKind::Read;
};

}
