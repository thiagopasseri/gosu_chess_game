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
  }.freeze

  SOUNDS = {
    moving_click: Gosu::Sample.new('media/moving_click.wav'),
    taking_click: Gosu::Sample.new('media/taking_click.wav')
  }.freeze


  COLORS = {
    cliked: Gosu::Color.rgba(255, 0, 0, 128),
    cotton: Gosu::Color.rgba(250, 244, 211, 200),
    buddha: Gosu::Color.rgba(189, 155, 25, 255),
    lightwood: Gosu::Color.rgba(130, 94, 92, 255),
    green: Gosu::Color.rgba(183, 244, 216, 255),
    weak_red: Gosu::Color.rgba(255, 0, 0, 60),
    weak_green: Gosu::Color.rgba(0, 255, 0, 60)

  }.freeze

  BOARD = {
    square_size: 50,
    padding: 30
  }.freeze

end