module Resources
  IMAGES = {
    pieces: {
      white: {
        pawn: Gosu::Image.new('media/Chess_plt60.png'),
        bishop: Gosu::Image.new('media/Chess_blt60.png'),
        queen: Gosu::Image.new('media/Chess_qlt60.png'),
        knight: Gosu::Image.new('media/Chess_nlt60.png'),
        rook: Gosu::Image.new('media/Chess_rlt60.png'),
        king: Gosu::Image.new('media/Chess_klt60.png')
      },
      black: {
        pawn: Gosu::Image.new('media/Chess_pdt60.png'),
        knight: Gosu::Image.new('media/Chess_ndt60.png'),
        bishop: Gosu::Image.new('media/Chess_bdt60.png'),
        rook: Gosu::Image.new('media/Chess_rdt60.png'),
        queen: Gosu::Image.new('media/Chess_qdt60.png'),
        king: Gosu::Image.new('media/Chess_kdt60.png')
      }
    }
  }
end